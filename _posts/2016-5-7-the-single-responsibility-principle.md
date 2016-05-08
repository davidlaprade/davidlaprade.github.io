---
title: "The Single Responsibility Principle"
excerpt: "How I fail to understand it and you can too."
---

The [Single Responsibility
Principle](https://en.wikipedia.org/wiki/Single_responsibility_principle),
or SRP for short, is the claim that programmers should limit what certain
units of code can do. It says: "don't make the basic bits of your code do too
much!" It's a good principle, and just about everyone agrees.

But the SRP in its uncontroversial form is a very "high level" claim: it gives
little by way of specific instructions. What are the units of code we should
limit? How do we know when those units are doing too much? How do we
objectively measure the "amount" that any given unit of code does? In other
words, it remains an open question just what specifically the SRP consists in.

The most famous attempt to say what the SRP amounts to comes from
Robert Martin. He puts it like this:

> A class should have only one reason to change.

Many people take Martin's statement of the SRP as incredibly clear and
illuminating. I don't. Let me explain.

To start, this quote is
[anthropomorphic](https://en.wikipedia.org/wiki/Anthropomorphism). From
wikipedia:

> Anthropomorphism is the attribution of human traits, emotions, and intentions
  to non-human entities

Discussions of code design/architecture are often maddeningly anthropomorphic.
We talk about where code "lives", about what it "knows".
We say that some code "talks" to other code, we say that we should "ask" certain
pieces of code certain things, and not "tell" them. And on and on.

But code is just
text: nothing more. It doesn't live anywhere, it doesn't know anything, it
doesn't talk, ask, tell -- not _literally_ anyway. When we say these
anthropomorphic things, we know they are just metaphors. We know they are really
just short for other things that we could have said instead.

But sometimes these anthropomorphic metaphors can be unhelpful, as they mask
what we really mean. They are especially unhelpful when we use them during
explanations. Unless someone already knows what the metaphors mean, using
them in explanations doesn't actually explain anything to the person.

It strikes me as anthropomorphic to describe code as having a "reason
to change". Code doesn't literally have reasons (to change, or to anything)
because it doesn't think. It's text in a
file. It has no mind, intentions, desires, wishes, hopes, dreams -- nor any of
the things necessary to have reasons for anything: for getting ice cream, for
riding a bike, for writing more code, for changing code, etc. Hence, I think
it's unhelpful to use this anthropomorphic language in an explanation of the
SRP.

So, anthropomorphism aside, what I think Martin must have meant is this:

> _Programmers_ should only have one reason to change a class.

Okay, that's better. Progammers definitely have reasons for changing code.
But now here's the problem. This is literally never true. Here are some reasons
a programmer might have to change _any_ class:

1. it contains a bug
2. it can be refactored so that it's easier to read
3. the language that it's written in has deprecated one of its methods
4. it can be refactored so that it's faster, more memory efficient
5. it or its methods weren't named as perspicuously as they could have been
6. the programmers have decided to follow a new style of programming, and this
  code follows a different style
7. a boss demands that it be rewritten because he thinks it's too confusing to
  explain to the CEO

And so on. Any code might have a
bug, and thus a programmer would have a reason to change it. Any code might
become deprecated, and thus a programmer would have a reason to change it. Any
code might have a faster implementation, and thus a programmer would have a
reason to change it. And so on. So, if Martin's quote is taken as an
adequate statement of the SRP,
then the SRP is literally not possible to ever abide by. No matter what anyone
writes, it has more than one "responsibility" -- more than one reason to change.

This seems like it's missed Martin's point. But why?

### What vs. How
I think it's important to distinguish between _what_ a piece of software does
and _how_ it does it. Consider two alternative implementations of the same
method:

{% highlight ruby %}
class User
  def full_name
    @full_name ||= "#{@first_name} #{@last_name}"
  end
end
{% endhighlight %}

{% highlight ruby %}
class User
  def full_name
    @full_name ||= @first_name + " " + @last_name
  end
end
{% endhighlight %}

__What__ these methods do is the same: they set a user's full name.
They differ, however, in __how__ they do it. The first uses string
interpolation, the latter concatenation. So there is definitely a difference
between what a piece of code does and how it does it.

We can use this distinction to clarify Martin's statement of the SRP.

> _Programmers_ should only have one reason to change what a class does.

This is definitely helpful. It seems like most of my objections now fall
away. If a class contains a bug, that's not a reason to change __what__ it does,
only __how__ it does it. If a class should be refactored for readability or
performance or deprecation, this again is not a reason to change what the class
does, only __how__ it does it. And so on.

Awesome. Progress!

### What is the Function?

Not so fast. Perhaps it's clear that we should differentiate between what a
piece of software does and how it does it. But even then, is it ever clear
exactly what a piece of software does? Consider again the examples from above:

{% highlight ruby %}
class User
  def full_name
    @full_name ||= "#{@first_name} #{@last_name}"
  end
end
{% endhighlight %}

{% highlight ruby %}
class User
  def full_name
    @full_name ||= @first_name + " " + @last_name
  end
end
{% endhighlight %}

Above I had suggested that __what__ these methods do is to set a user's full
name. But couldn't someone reasonably object that __what__ these methods do
is _return_ the user's full name? The fact that they do so by setting an
instance method is simply immaterial to the point -- to think otherwise is to
confuse part of __how__ these methods are implemented with __what__ it is
that they do.

How could one adjudicate between two programmers who disagreed on this matter?
Which one would be right and which one wrong? Can we even answer this question?
It's not
clear to me that we can -- nor that any rules we might have for doing so would be
non-arbitrary and objective. It really just seems like there's no truth of the
matter in such a dispute.

This is another complaint that I have with Martin's formulation of the SRP. It
often just doesn't seem like there's a truth of the matter about __what__ any
given class does. Because of that, it's often unclear what the SRP says that the
the programmer should not change about that class.
Would I be violating the SRP to rename the instance
variable `@full_name` to `@complete_name`? Could I remove it all together? That
really depends on __what__ we say the method is doing!

Perhaps not all hope is lost.

The __what__ that I think Martin has in mind is the _functional role_ that a
piece of software plays within the system. Just like we can ask "what does a
heart do" we can ask "what does this class/method do". In both cases we're
asking for something's functional role in a system.

A great deal of effort has been spent in theoretical biology attempting to
clarify the notion of a functional role.
