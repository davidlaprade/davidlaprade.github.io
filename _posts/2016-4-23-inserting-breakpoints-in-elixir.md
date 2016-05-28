---
title: "Breakpoints in Ruby and Elixir"
comments: true
excerpt: "Knowing how to set and interact with breakpoints in a language is
crucial to efficient debugging. Here's a side-by-side comparison of
breakpoints in Ruby and Elixir."
---

Like many [Ruby](https://en.wikipedia.org/wiki/Ruby_(programming_language))
programmers, I've been learning
[Elixir](https://en.wikipedia.org/wiki/Elixir_(programming_language)) on the
side. Elixir is a functional programming language with an approachable,
Ruby-like syntax. Unlike Ruby, however, Elixir is crazy fast -- making it an
exciting alternative for back-end programming.

One of the basic things anyone needs to learn when picking up a new language is
how to set breakpoints. Intuitively, a breakpoint is a line of code where the
machine will pause when executing the program, opening up a
[REPL](https://en.wikipedia.org/wiki/Read%E2%80%93eval%E2%80%93print_loop)
in which the user can evaluate code interactively within the scope --
i.e. with access to all of the variables, functions, modules, etc., that would
otherwise be available to him/her at the line of the breakpoint.

Breakpoints are exceedingly useful when debugging, as they dramatically speed up
the feedback loop. Rather than peppering your code with lines that write to
standard out, compiling (if need be), running the program, waiting for it to
finish, reading the output,
realizing that you actually needed to know what __that__ function returned,
adding a new line to log the return value, saving the program, compiling again,
re-running it, waiting for it to finish, reading the output, ... then finally
fixing the problem, only to realize that you now have to go back to remove
all of those logging statements you added everywhere -- __instead__, you could
just set a breakpoint and literally skip that whole, awful process.
Put another way, breakpoints with respect to debugging are like print statements on crack.

So, assuming you agree that knowing how to debug code
in a language is an important first step to learning it. And
assuming I've convinced you of the need to set breakpoints when debugging,
then hopefully the following comparison of breakpoints in Ruby and Elixir
will be of interest to you.

I'm going to break this up into three steps.

### 1. Set up the code to be debugged

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

### 2. Trigger your breakpoint

In Ruby you do this:

{% highlight bash %}
$ irb
>> $LOAD_PATH << '.'
=> # the contents of Ruby's current load path
>> require 'example'
=> true
>> Example.my_method "yo"

From: ./example.rb @ line 6 Example#my_method:

    4: def self.my_method(arg)
    5:   # some code
 => 6:   binding.pry # your breakpoint
    7:   # some code
    8: end

# you're in the interactive REPL!
[1] pry(main)> arg
=> "yo"
{% endhighlight %}

In Elixir you'd do this:

{% highlight bash %}
$ iex
iex(1)> c "example.exs" # compile your file
[Example]
iex(2)> Example.do_method("hey")
Request to pry #PID<0.57.0> at file_name.exs:3

  def do_method(some_arg) do
    # some code
    IEx.pry # your breakpoint
    # some code

Allow? [Yn] Y

# you're in the interactive REPL!
pry(1)> some_arg
"hey"
{% endhighlight %}

### 3. Interact with your breakpoint

At this point, enter whatever code you want to start debugging.

In Ruby you exit the pry session and skip to the next breakpoint with the
same command: `quit`.

In Elixir, you exit the pry session with `CNTL + C` and skip to the next
breakpoint with `respawn`.
