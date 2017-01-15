---
title: "Replacing Controller Mixins with Services"
tags: ruby rails architecture
excerpt: "How to use Rails services to extract shared behaviors out of
controllers. This helps to keep your
controllers light on logic, self-documenting, and free of tangled dependencies."
---

This is a concrete example of how to use Rails services to extract shared
behaviors out of controllers. Doing this helps to keep your controllers:

  * light on logic,
  * self-documenting, and
  * free of tangled dependencies

Suppose you have a restaurant app and in it a controller that looks like this:

{% highlight ruby %}
# app/controllers/map_controller.rb
class RestaurantsController < ApplicationController

  def index
    locations = Restaurant.display_on_map

    @markers = Gmaps4rails.build_markers(locations) do |location, marker|
      marker.lat(location.latitude)
      marker.lng(location.longitude)
      marker.infowindow(
        render_to_string(
          partial: 'map_info_window', locals: { location: location }
        )
      )
    end
  end

end
{% endhighlight %}

Here we're pulling some data out of the DB and generating a bunch of marker HTML
that [Gmaps4rails](https://github.com/apneadiving/Google-Maps-for-Rails) is
going to use to plot our restaurants on a Google maps iframe,
which we will render in our view.

This is working well for us, but eventually we find that we want to display a
slightly different map on another page of our application: a map of pizza
places.

So, we create a new controller:

{% highlight ruby %}
# app/controllers/pizza_places_controller.rb
class PizzaPlacesController < ApplicationController
  def index
    locations = Restaurant.display_on_map.pizza_places

    @markers = Gmaps4rails.build_markers(locations) do |location, marker|
      marker.lat(location.latitude)
      marker.lng(location.longitude)
      marker.infowindow(
        render_to_string(
          partial: 'map_info_window', locals: { location: location }
        )
      )
    end
  end
end
{% endhighlight %}

Now we have two controllers that do pretty much the same thing. Sensing the
repetition, and keen to abstract it away, we might be tempted to reach for
a mixin:

{% highlight ruby %}
# app/controllers/map_helper.rb
module MapHelper
  def build_map_markers(locations)
    @markers = Gmaps4rails.build_markers(locations) do |location, marker|
      marker.lat(location.latitude)
      marker.lng(location.longitude)
      marker.infowindow map_info_for(location)
    end
  end

  def map_info_for(location)
    render_to_string(
      partial: 'shared/map_info_window', locals: { location: location }
    )
  end
end
{% endhighlight %}

We can now refactor our controllers like this:

{% highlight ruby %}
class RestaurantsController < ApplicationController
  include MapHelper # add our mixin

  def index
    @markers = build_map_markers(Restaurant.display_on_map)
  end
end

class PizzaPlacesController < ApplicationController
  include MapHelper # add our mixin

  def index
    @markers = build_map_markers(Restaurant.display_on_map.pizza_places)
  end
end
{% endhighlight %}

This feels a lot better. Our controllers are dead simple. There's no more
redundant code. Etc. Everyone feels good about it. On we go!

As we continue developing our app, however, our `RestaurantsController`
grows in complexity. We add:

* some other actions,
* some other mixins,
* user authentication,
* `before_actions`,
* caching
* `private` methods,
* error catching,
* a `Base` class
* etc

Before long, our `RestaurantsController` looks like this:

{% highlight ruby %}
class RestaurantsController < RestaurantsBaseController
  include SslRequirement
  include MapAuthentication
  include MapHelper

  rescue_from ActiveRecord::RecordNotFound do |exception|
    redirect_to(restaurants_path, alert: "Restaurant not found")
  end

  caches_action :index, expires_in: 1.day, :cache_path => Proc.new do |c|
    {
      updated: Restaurant.display_on_map.maximum('updated_at').to_i,
      count: Restaurant.display_on_map.count
    }
  end

  ssl_required :create, :destroy

  before_action :require_login, except: [:index]

  before_action :set_styles

  def show
    render map_info_for(Restaurant.find(params[:id]))
  end

  def index
    @markers = build_map_markers(Restaurant.display_on_map)
  end

  def new
   # . . .
  end

  def create
   # . . .
  end

  private

    def set_styles
      # . . .
    end

end
{% endhighlight %}

A 6 months go by.
We get a bug report: a restaurant owner says the information for his restaurant
is wrong on our map.

So, we open up our `RestaurantsController` to try to figure out what's
going on. We jump to `#show` and we're met with this `#map_info_for`
method. _Ah yes_. We have a fuzzy memory of some behavior we abstracted away
months back. _Where did we put this_, we wonder.

_A private method?_ -- we go through the private methods in the controller.
_Nope, not here._

_A method in our base class?_ -- we jump into the base class. _Not here either._

_A method in our ApplicationController?_ -- we look there. _Gah._

Then it hits us: _this must be in one of our mixins._ Well, which mixin?
We have mixins in our:

* `ApplicationController`,
* `RestaurantsBaseController`, _and_
* `RestaurantsController`.

What a pain to go through them all!

So, at the end of our rope, we turn to our last resort:
`grep`-driven-development. Of course it works. We find the method buried in our
`MapHelper`, where we so happily placed it a half-year-or-so ago. We debug the
problem and resolve the customer's issue.

Great. Now we'd like to write a regression test for this kind of thing. But what a
pain that is. We can't even interact with this method outside of a full controller
test, requiring us to load all of Rails, all of Rails' dependencies, to make up
a full set of params, factory data, `ActiveRecord` queries, user authentication,
etc. So, we don't write a test. We just make a mental note to check on this
behavior when we make updates to the map in the future.

Some more time goes by.

Our restaurant application -- especially our map -- becomes super popular.
We're getting hundred's of thousands of hits per day. All of a sudden we have to
start paying Google for the volume of requests we're making to their Maps API.
It's getting to be really expensive for the company.

So, we decide to isolate our application's dependency on
[Gmaps4rails](https://github.com/apneadiving/Google-Maps-for-Rails). We'd like
to put ourselves in a position to swap it out for something else if need be.

But now we have another problem. We're including our `MapHelper` in a lot of
places. And not all of the places that we're including it are even using the
method of the `MapHelper` that uses Google Maps. In some controllers, for
example, we seem to just be using `#map_info_for`, as in the `#show` action above.
This would be a great place to start rolling back our dependence on Google Maps.
But our mixin is getting in the way. Should we break it up into two mixins? _No
-- that doesn't make sense. `#generate_markers` clearly depends on
`#map_info_for`_.
Should we just bite the bullet and re-implement `#map_info_for` in each such
controller? Even then, we're not sure that `#generate_markers` isn't being
called on the controller somewhere that isn't obvious. We don't want a surprise
bug out in production.

In short, we're afraid to refactor our own code.

There must be a better way.

### A Map Service

Instead of creating a `MapHelper` module, we could have created a
`MapService` class:

{% highlight ruby %}
# app/services/map_service.rb
class MapService
  class << self

    def build_map_markers(locations, renderer)
      @markers = Gmaps4rails.build_markers(locations) do |location, marker|
        marker.lat(location.latitude)
        marker.lng(location.longitude)
        marker.infowindow(map_info_window(location, renderer))
      end
    end

    def map_info_window(location, renderer)
      renderer.render_to_string(
        partial: 'shared/map_info_window', locals: { location: location }
      )
    end

  end
end
{% endhighlight %}

A few things have changed here:

* the code for this object is in a new folder `/app/services`, not mixed up in
  the `/app/controllers` folder
* the new object is a `Class`, not a `Module`
* the `#build_map_markers` and `#map_info_window` methods are class methods, not
  instance methods
* the [arity](https://en.wikipedia.org/wiki/Arity) of both methods has changed
  from 1 to 2 arguments
* there is [dependency
  injection](https://en.wikipedia.org/wiki/Dependency_injection) going on: a
  `renderer` object is now required,
  which must implement a specific interface

We can use this object in our controller as follows:

{% highlight ruby %}
class RestaurantsController < ApplicationController
  # goodbye mixin!
  def index
    @markers = MapService.build_map_markers(Restaurant.display_on_map, self)
  end

  def show
    render MapService.map_info_window(Restaurant.find(params[:id]), self)
  end
end
{% endhighlight %}

This should look even slightly cleaner than what we had above. Note here that
the renderer is just the controller itself.

There are many benefits to this approach. Chief among them is how well this
scales.

We saw above that as our application grew in complexity, our mixin became harder
and harder to work with. We saw that it was difficult to:

* locate code
* write tests
* isolate dependencies
* refactor

This approach avoids the problems we encountered earlier.

By explicitly
[namespacing](https://en.wikipedia.org/wiki/Namespace) our helper methods to the
`MapService` we immediately know where to look for them. No digging around. No
grep-driven-development. Just open the `MapService` file and get going. This
makes both debugging and refactoring much easier.

By adding dependency injection, we remove the need to simulate HTTP requests
when testing the `MapService`. We don't need any controllers, params, DB persistence,
queries. Heck, we don't even need to load Rails if we don't want to! We
just pass in a test `double` that implements a `#render_to_string` method
instead of an actual Rails controller instance, and we're off to the races.

Refactoring is also much simpler. If we want to separate these methods to
isolate our Google Maps dependencies, it's trivial to do so. We just create a
separate `MapService` -- perhaps a `MapMarkerService` -- that uses the other
service as a dependency. We no longer have to worry about accidentially removing
`#map_info_window` when all we want to get rid of is `#generate_map_markers`. We
don't have to live with duplicated code to isolate our dependencies.

### Conclusion

This way of abstracting duplicate code has been a huge win on my projects.
I encourage you to give it a try!
