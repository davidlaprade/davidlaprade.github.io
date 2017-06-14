---
title: "Inline Enumerator Messages in Ruby"
tags: ruby
excerpt: "A little-known trick to simplify iterating through enumerators."
---

Many rubyists are familiar with the following shorthand:

{% highlight ruby %}
# normal
collection.each {|obj| obj.delete}

# shorthand
collection.each(&:delete)
{% endhighlight %}

This shorthand makes it easy to send each element of an enumerator a specific
message.

But what if you want to send each element of your collection to a method on
_another_ object?

For example, what if you had an array of bill amounts and you wanted to map this
to an array of Bill objects? You could:

{% highlight ruby %}
amounts.map do |amount|
  Bill.new(amount)
end
{% endhighlight %}

The short way to do this, however, is this:

{% highlight ruby %}
amounts.map(&Bill.method(:new))
{% endhighlight %}

Just a cool trick!
