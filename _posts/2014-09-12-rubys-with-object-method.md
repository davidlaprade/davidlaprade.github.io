---
title: "Enumerator's #with_object method"
excerpt: "The benefits of this handy, oft-neglected ruby method."
---

Suppose you want to create a new array from an old one.
You want the new array to contain elements greater than 3.
So, for instance, the old array might be:

{% highlight ruby %}
array = [1,2,3,4,5,6]
{% endhighlight %}

There are several reasons why something like `array.delete`
isn't fit for this job:

* It requires you to pass in a value to delete from the array.
And, in our case, we want to delete any value greater than 3.
There may be far more values than we can specify!
* `array.delete` changes the old array to create the new one.
So, if you wanted to keep a record of what was in the old array,
you'd have to do something like first create a duplicate. Inconvenient.
* `array.delete` returns the value deleted, not the new array object
--which is unhelpful when you're interested in stringing your
functions together.

Ruby's "map" and "collect" methods don't really do the kind of
work we're interested in either. By hypothesis, you want to
get rid of some of the old elements. And all `array.map` and
`array.collect` do is change certain members--they don't get
rid of members. Still, you could try something like this:

{% highlight ruby %}
array = [1,2,3,4,5,6]
new = []
array.map {|value| value > 3 ? new << value : value}
new
=> [4,5,6]
{% endhighlight %}

But the core of this method once again doesn't return the new
array object you're interested in. So this can't be strung together.

Now, Ruby's `Array#find_all` method works well for the job
just described since the objects that you want are in the old array.

{% highlight ruby %}
array = [1,2,3,4,5,6]
array.find_all {|x| x>3}
=> [4,5,6]
{% endhighlight %}

But what if the new objects you want to include are not in the
old array? What if you wanted the new array to contain just
the objects in the old array greater than 3, multiplied by 2?
To do this using `array.find_all`, you would need to tack on a
`map` function. For example:

{% highlight ruby %}
array = [1,2,3,4,5,6]
array.find_all {|x| x>3}.map {|x| x\*2}
=> [8,10,12]
{% endhighlight %}

And what if we wanted to append these new values to the end
of another array?--say: to `[4, 6]`. We'd need to do something
like:

{% highlight ruby %}
array = [1,2,3,4,5,6]
[4, 6] << array.find_all {|x| x>3}.map {|x| x\*2}
=> [4, 6, 8, 10, 12]
{% endhighlight %}

This works well. But it would be nice if we could do everything
in just one step. Enter the Enumerator method I have just
discovered: `#with_object`. What `#with_object` allows you to do
is pass in an arbitrary object to the block, and then return that
object afterwards. So, for example, we could pass `[4,6]` into the
block directly, give it the name "o" and just put the items into
it one by one as we iterate through the block, then get the
modified object back. Like this:

{% highlight ruby %}
array = [1,2,3,4,5,6]
array.each.with_object([4,6]) {|x,o| o << x\*2 if x>3}
=> [4, 6, 8, 10, 12]
{% endhighlight %}

Very handy!

The `Enumerator#with_object` method can also be used to elegantly
perform tasks that would take a lot of code using just `map` and `find`.
Suppose, for instance, that you wanted to find the coordinates of
each occurrence of a given object in a 2D array; e.g. if I wanted
to find the coordinates of "foo" in:

{% highlight ruby %}
array = [["foo", "bar", "lobster"],
         ["camel", "trombone", "foo"]]
{% endhighlight %}

To do this using just `map` and `find_all`, you would need to do something like this:

{% highlight ruby %}
array.map.with_index{|row,row_index|
  row.map.with_index {|v,col_index|
    v=="foo" ? [row_index,col_index] : v }
}.flatten(1).find_all {|x| x.class==Array}
=> [[0,0],[1,2]]
{% endhighlight %}

Inelegant, to say the least! But `Enumerator#with_object` affords a more direct solution:
{% highlight ruby %}
array.each.with_index.with_object([]) {|(row, row_id), o|
  row.each.with_index {|value, col_id|
    o<<[row_id, col_id] if value == "foo"
  }
}
=> [[0,0],[1,2]]
{% endhighlight %}

Neat!
