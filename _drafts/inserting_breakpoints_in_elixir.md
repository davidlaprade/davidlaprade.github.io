Compare with `binding.pry` in ruby.

Steps:

1. Set up your module:

In ruby you'd do this:
```
class Example
  require 'pry'

  def self.my_method(arg)
    # ...where you want to insert your breakpoint
    binding.pry
  end
end
```

In elixir you'd do this:
```
defmodule Example do
  require IEx

  def do_method(some_arg) do
    # ...where you want to insert your breakpoint
    IEx.pry
  end
end
```

2. Trigger your break point.

In ruby you could do something like this:

```
irb
> require 'path_to_example_rb'
true
> Example.my_method "arg"

# pry is triggered
```

In elixir you'd do this:

``` shell
iex
> c "file_name.exs"
[Example]
> Example.do_method( "" )
Request to pry #PID<0.57.0> at file_name.exs:3

  def do_method(some_arg) do
    # ...where you want to insert your breakpoint
    IEx.pry


Allow? [Yn] Y

Interactive Elixir (1.2.1) - press Ctrl+C to exit (type h() ENTER for help)
pry(1)>
```

3. Interact with your breakpoint.

In ruby you exit the pry session and skip to the next breakpoint with the
same command: `quit`.

In elixir, you exit the pry session with `CNTL + C` and skip to the next
breakpoint with `respawn`.

