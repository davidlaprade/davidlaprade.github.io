---
title: "Breakpoints in Ruby and Elixir"
excerpt: "Knowing how to set and interact with breakpoints in a language is
crucial to efficient debugging. Here's a side-by-side comparison of
breakpoints in Ruby and Elixir."
---

Like many [Ruby](https://en.wikipedia.org/wiki/Ruby_(programming_language))
programmers, I've been learning
[Elixir](https://en.wikipedia.org/wiki/Elixir_(programming_language)).
Elixir is a functional programming language with an approachable,
Ruby-like syntax. Unlike Ruby, however, Elixir is crazy fast -- making it an
exciting alternative for back-end programming.

One of the basic things anyone needs to learn when picking up a new language is
how to set [breakpoints](https://en.wikipedia.org/wiki/Breakpoint). So, if you
know how to set breakpoints in Ruby, how can you translate this into Elixir?

I'm going to break this up into three steps:

  * insert your breakpoint
  * trigger your breakpoint
  * interact with your breakpoint

### 1. Insert Your Breakpoint

In Ruby you do this:

{% highlight ruby %}
# ./example.rb
class Example
  require 'pry' # load the library, `gem install pry` first

  def self.my_method(arg)
    # some code
    binding.pry # your breakpoint
    # some code
  end
end

Example.my_method('yo')
{% endhighlight %}

In Elixir you do this:

{% highlight elixir %}
# ./example.exs
defmodule Example do
  require IEx # load the library

  def do_method(some_arg) do
    # some code
    IEx.pry # your breakpoint
    # some code
  end
end
{% endhighlight %}

### 2. Trigger Your Breakpoint

In Ruby you do this:

{% highlight bash %}
$ ruby example.rb # just run the file!

From: ./example.rb @ line 7 Example.my_method:

    4: def self.my_method(arg)
    5:   # some code
 => 6:   binding.pry # your breakpoint
    7:   # some code
    8: end

# you're in the interactive REPL!
[1] pry(Example)> arg
=> "yo"
{% endhighlight %}

In Elixir you'd do this:

{% highlight bash %}
$ iex
iex(1)> c "example.exs" # compile your file
iex(2)> Example.do_method("hey")
Request to pry #PID<0.57.0> at file_name.exs:3

  def do_method(some_arg) do
    # some code
    IEx.pry # your breakpoint
    # some code

Allow? [Yn] # type Y

# you're in the interactive REPL!
pry(1)> some_arg
"hey"
{% endhighlight %}

**NOTE: The single most important difference between breakpoints in Ruby and
Elixir is that Elixir breakpoints have to be triggered from within a running
Elixir
[REPL](https://en.wikipedia.org/wiki/Read%E2%80%93eval%E2%80%93print_loop).** This
is optional in Ruby -- and, indeed, most of the time you trigger your breakpoint
outside of IRB, as in the example above.

This also extends to debugging in elixir tests. If you want to trigger a
breakpoint in a test file, you need to run that test within `iex` like so:

{% highlight bash %}
$ iex -S mix test --trace
Request to pry #PID<0.57.0> at my_test.exs:4

#...
{% endhighlight %}

The `--trace` option prevents Elixir from timing out during a debugging session.

### 3. Interact with Your Breakpoint

At this point, enter whatever code you want to start debugging.

In Ruby you exit the pry session and skip to the next breakpoint with the
same command: `quit`.

In Elixir, you exit the pry session with `CTRL + C` and skip to the next
breakpoint with `respawn`.
