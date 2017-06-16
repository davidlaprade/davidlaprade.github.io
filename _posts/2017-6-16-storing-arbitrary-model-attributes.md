---
title: "Storing Arbitrary Model Attributes in Rails"
tags: ruby rails architecture
excerpt: "Sometimes you might want to have access to an indefinite number of attributes on an object and persist these attributes to a database. Here's how I recently
implemented this in Rails."
---

Sometimes you might want to have access to an indefinite number of attributes on
an object and persist these attributes to a database. Here's how I recently
implemented this in Rails.

### Background

The application I was working on had an `Event` class and a related
`EventRegistration` class. `Events` have many `EventRegistrations`, linking
individual users to specific events. The `event_registrations` table looked
roughly like this:

| id | event_id | user_id | created_at |
|----|----------|---------|------------|
| 1  |   3      | 83723   |  12/26/16  |

A feature was requested by marketing: they wanted to send emails to people
based on when the user planned on arriving at a certain class of events --
Conferences. So, for every user registered for a conference `Event`, we
wanted to be able to store the particular date the user planned to arrive.

We could have simply added a column to our registration table, like this:

| id | event_id | user_id | arrival_date | created_at |
|----|----------|---------|--------------|------------|
| 1  |   3      | 83723   |  3/12/17     |  12/26/16  |

But this would have lead to large numbers of `null` values in our database. Many
events, after all, don't really have arrival *dates*:

* graduations
* birthday parties
* baseball games
* cookouts
* weddings

It also seemed clear that this kind of request could and would be made again: where
some department wanted to store some arbitrary information specific to an
individual, and only relevant to some events. They might want to store:

* where the individual is staying
* dietary preferences
* travel type (plane, bus, car, etc)
* whether the individual will be bringing a gift
* the name of the person's "plus one"
* what meal option was selected
* whether and how the person RSVP'ed

And so on.

The problem, then, was how to write the code for this in a way that was both
flexible and scalable.

I decided on a combination of an [EAV
table](https://en.wikipedia.org/wiki/Entity%E2%80%93attribute%E2%80%93value_model)
and [Single Table
Inheritance](https://en.wikipedia.org/wiki/Single_Table_Inheritance). The
benefits of this approach were:

* minimal null values stored in the database
* no additional database schema changes would be needed to add attributes in the
  future
* specialty behavior is isolated and namespaced so that it is easy to find and
  understand

Now here's the code.

### Entity Attribute Value Modeling

First, the EAV implementation. I created a new table and corresponding
`Metadata` model:

{% highlight ruby %}
class EventRegistrationMetadata < ApplicationRecord
  # COLUMNS
  # -------------------------------
  # INTEGER - id
  # INTEGER - event_registration_id
  # STRING  - attribute_id
  # STRING  - value
  # -------------------------------

  class Attributes
    ALL = [
      ARRIVAL_DATE = "arrival_date"
      # additional attributes will be added here
    ]
  end

  Attributes::ALL.each do |attr|
    scope attr, ->{ where( attribute_id: attr) }
  end

  belongs_to :event_registration

  validates_inclusion_of :attribute_id,
    in: Attributes::ALL,
    message: "is not a permitted attribute"

  validates_uniqueness_of :attribute_id,
    scope: :event_registration_id,
    if: -> { Attributes::ARRIVAL_DATE == attribute_id },
    message: "already set"

  validate :value_present

  private

  def value_present
    unless value.present?
      errors.add(attribute_id.titleize, "cannot be blank")
    end
  end
end
{% endhighlight %}

Step by step, this is what it is doing.

First, the database schema. It's very simple:

{% highlight ruby %}
# COLUMNS
# -------------------------------
# INTEGER - id
# INTEGER - event_registration_id
# STRING  - attribute_id
# STRING  - value
# -------------------------------
{% endhighlight %}

Note that `attribute_id` is being used here, though it is a string. There are
two reasons why:

* `attribute` is a reserved word in Rails
* EAV tables traditionally use an `attribute_id` column to join to an `attributes`
table

In this case, I felt there was little value to adding an attributes table, and
decided instead to just hard-code my attribute names directly into the model. I
took this route for a few reasons. First, I didn't expect for there to ever be
an overwhelming number of metadata attributes. Second, I've run into scenarios
like this before and have been burnt: scenarios in which I've made a basic table
to store data that I need to reference throughout the code. The basic issue is
this:

When you want to reference the data in the code, you only have two options:

* litter your code with the data
* keep an up-to-date, hard-coded registry of the data and use that registry as a
  wrapper for the data

And neither of these options is good.

An example of the first option is to do something like this:

{% highlight ruby %}
registration.metadata.find_by_name("arrival_date")
{% endhighlight %}

Here, the data "arrival_date" is used to pull a line in the database.
This will work, but it directly couples your implementation to the data. As soon
as your data changes -- e.g. as soon as you change "arrival_date" to "arrival
date" in the DB -- your app blows up. Or, worse still, you'll feel compelled to
never change the data in your DB because you know it will break your app.  That
defeats the entire purpose of having a database!

The other option, then, is to keep a registry of references to the table in your
code somewhere. This allows you to do things like this:

{% highlight ruby %}
registration.metadata.find_by_name(Metadata::Attributes::ARRIVAL_DATE)
{% endhighlight %}

This works well, and doesn't tie your implementation to your data. However, it's
just duplicating effort. What's the point of having a DB table at all if you
just end up having to hard-code the whole thing in your app?

To avoid these kinds of problems, then, I just make a quick hard-coded database
of the attributes I will use, which is the next bit of code we see in the model:

{% highlight ruby %}
class Attributes
  ALL = [
    ARRIVAL_DATE = "arrival_date",
    # additional attributes will be added here
  ]
end
{% endhighlight %}

This creates an `Attributes` class namespaced to the `Metadata` model we're
creating. I like this because it will give us a clear reference throughout our
codebase for the string values we'll be using for attributes. This will keep our
code [DRY](https://en.wikipedia.org/wiki/Don%27t_repeat_yourself), making it
easy to update these values in one fell swoop if need be, while also decoupling
our application logic from the data itself, which should make it more resilient
to changes in that data. It also allows us to do things like this, the next
snippet of code:

{% highlight ruby %}
Attributes::ALL.each do |attr|
  scope attr, ->{ where( attribute_id: attr) }
end
{% endhighlight %}

Here we are using the `ALL` constant defined on our namespaced `Attributes`
class to dynamically define some scopes on our model. This is just for
convenience, really. But it will allow us to easily define some handy methods on
our `EventRegistration` model soon enough.

Speaking of the `EventRegistration` model, the next bit of code registers the SQL
join between these two tables with ActiveRecord.

{% highlight ruby %}
belongs_to :event_registration
{% endhighlight %}

And, in Rails 5+, `belongs_to` gives us a presence validation on
`event_registration_id` for free. The corresponding code on the
`EventRegistration` model is this:

{% highlight ruby %}
class EventRegistration < AppilcationRecord
  has_many :event_registration_metadata, dependent: :destroy

  alias :metadata :event_registration_metadata
end
{% endhighlight %}

Super simple. The alias simply provides us with the convenience of calling
`event_registration.metadata` instead of the more verbose
`event_registration.event_registration_metadata`.

Moving on:

{% highlight ruby %}
  validates_inclusion_of :attribute_id,
    in: Attributes::ALL,
    message: "is not a permitted attribute"
{% endhighlight %}

This ensures that we never accidentally try to create some metadata for a
non-registered Attribute.

And this ensures that any given `EventRegistration` never has more than value for
this attribute. (No registration should have more than one arrival date.)

{% highlight ruby %}
  validates_uniqueness_of :attribute_id,
    scope: :event_registration_id,
    if: -> { Attributes::ARRIVAL_DATE == attribute_id },
    message: "already set"
{% endhighlight %}

Notice that this validation is conditional. There might be some attributes that
we would want to allow multiple values for, e.g. "Guest Name".

Finally, we have a custom validation:

{% highlight ruby %}
  validate :value_present

  def value_present
    unless value.present?
      errors.add(attribute_id.titleize, "cannot be blank")
    end
  end
{% endhighlight %}

I honestly could have done this instead:

{% highlight ruby %}
  validates_presence_of :attribute_id, message: "cannot be blank"
{% endhighlight %}

which would have been 98% identical to what I have, except that the validation
error would have been "Attribute id cannot be blank", which is not very
user-friendly. Instead, the validation errors we'll get will look like "Arrival
Date cannot be blank" -- which is suitable for users to see.

That's the EAV portion. Hopefully it's very straightforward, boring code.

### Single Table Inheritance

A new requirement was handed down: we needed to set default
arrival dates for all conference attendees that were the start dates of the
conferences.

To do this, I decided to make a new model that inherits from the base
`EventRegistration` model and uses the same database table. This would allow me
to keep all of the specialized logic associated with conference registrations
separate and out of the way of other registrations. To do this, however, I would
need to use Single Table Inheritance (STI).

Rails makes STI really easy. The first step is just
adding a "type" column on your table, in this case `event_registrations`:

{% highlight ruby %}
class AddTypeToEventRegistrations < ActiveRecord::Migration[5.0]
  def change
    add_column :event_registrations, :type, :string
  end
end
{% endhighlight %}

Now for the model:

{% highlight ruby %}
class ConferenceRegistration < EventRegistration

  def arrival_date
    self.metadata.arrival_date.pluck(:value).first
  end

  before_save :set_default_arrival_date, unless: :arrival_date

  private

  def set_default_arrival_date
    self.metadata.arrival_date.create(value: self.event.start_date)
  end

end
{% endhighlight %}

Notice the `#arrival_date` method? Here we're able to make use of the metadata
scopes we dynamically defined earlier to pull out the registration's associated
arrival date.

Then, with a `before_save` callback, we are able to easily add a default arrival
date for each `ConferenceRegistration` instance. The benefit of this approach is
that regular EventRegistrations can be created and saved without triggering any
of this logic. We don't even have to think about it.

### Conclusion

Rails makes STI and EAV quite easy, and these two architectural patterns can be
combined to powerful effect.


