usually you don’t have to explicitly invoke `self` when calling an instance
method within the definition of an instance method

```
class Person

  def first_name
   "Jim"
  end

  def last_name
    "Johnson"
  end

  def full_name
    first_name + " " + last_name
  end

end
```

```
>> p = Person.new
>> p.full_name
=> "Jim Johnson"
```

This works because in the definition of `#full_name` Ruby's interpreter can tell
that `first_name` and `last_name` are really short for `self.first_name` and
`self.last_name`. This means that most of the time you can just exclude `self`.

But not always.

```
class Person
  attr_accessor :name

  def initialize(string)
    name = string
  end
end
```

`#attr_accessor :name` is short for the following code in Ruby:

```
def name
  @name
end

def name=(var)
  @name = var
end
```

So, why does this happen?


```
>> p = Person.new('joey')
>> p.name
=> nil
```

Why didn't Ruby's interpreter understand that `name = string` was short for
`self.name = string`? Instead, it appears that Ruby thinks we're setting a
local variable `name`.


The problem goes away if you explicitly invoke `self`, e.g.

```
class Person
  attr_accessor :name

  def initialize(string)
    self.name = string
  end
end
```

```
>> p = Person.new('joey')
>> p.name
=> 'joey'
```

There's a good post of the use of `self` in ruby
[here](https://www.jimmycuadra.com/posts/self-in-ruby/). In reference to this
problem, it tries to explain it in the following way:

> In the case of assignment, Ruby must assume you want to assign to a local
> variable, because if it sends the name= message to self, you are left with no
> way to set a local variable.

But this isn't actually true. If the interpretter simply implemented something
like this, it would easily still be able to set local variables:

```
if I see `x = y` in an instance method definition, first check if `x=` is a
defined instance method, if it is, then `x=y` is short for `self.x=y`, else
define a new local variable `x` and set its value to `y`
```
