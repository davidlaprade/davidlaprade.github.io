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

It strikes me as anthropomorphic to describe code as having a "reason
to change". Code doesn't literally have reasons (to change, or to anything)
because it doesn't think. It's text in a
file. It has no mind, intentions, desires, wishes, hopes, dreams -- nor any of
the things necessary to have reasons for anything: for getting ice cream, for
riding a bike, for changing.

Anthropomorphism aside, what I think Martin must have meant is this:

> Programmers should only have one reason to change a class.

Okay, that's better. Progammers definitely have reasons for changing code.
But now here's the problem. This is literally never true. Here are some reasons
a programmer might have to change _any_ class:

1. it contains a bug
2. it can be refactored so that it's easier to read
3. the language that it's written in has deprecated one of its methods
4. one of its dependencies has deprecated one of its methods
5. it can be refactored so that it's faster, more memory efficient
6. it or its methods weren't named as perspicuously as they could have been
7. the programmers have decided to follow a new style of programming, and this
  code follows a different style
8. a boss demands that it be rewritten
9. it's too confusing to explain to the CEO during funding requests

And so on. Any code might have a
bug, and thus a programmer would have a reason to change it. Any code might
become deprecated, and thus a programmer would have a reason to change it. Any
code might have a faster implementation, and thus a programmer would have a
reason to change it. And so on. So, if Martin's quote is taken as an
adequate statement of the SRP,
then the SRP is literally not possible to abide by ever. No matter what anyone
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

Not so fast. Perhaps it's clear that we should differentiate between what a
piece of software does and how it does it. But even then, is it ever clear
exactly what a piece of software does?

### What Does Software Do?

Recall the example from above:

{% highlight ruby %}
class User
  def full_name
    @full_name ||= "#{@first_name} #{@last_name}"
  end
end
{% endhighlight %}

Above I had suggested that __what__ this method does is set a user's full
name. But couldn't someone reasonably object that __what__ this method does
is _return_ the user's full name? The fact that it does so by setting an
instance method is simply immaterial to the point -- to think otherwise is to
confuse part of __how__ the method is implemented with __what__ it is that it
does.

What we're seeing here is that even granting the how vs. what distinction,
the way we divide up functionality between these two categories
is not beyond dispute.

There's a further issue. Any piece of software can be made to seem as if
it does only one thing if described from a high enough level.
Since Martin focuses on classes -- let's look at a class:

{% highlight ruby %}
class PaymentProcessor
  def charge(customer)
    # ...
  end

  def refund(charge)
    # ...
  end
end
{% endhighlight %}

How many things does this class do? Well, if we speak at a relatively
high-level, it would seem like this class does one thing: it processes payments.
But it seems equally accurate to say that this class does two things:
it (1) makes charges and (2) refunds charges. The question here is just a
question of language: which level are we supposed to speak at?

How could one adjudicate between two programmers who disagreed on these matters?
Which would be right and which wrong? It's not clear that this
question has an answer -- nor that there are any rules for answering
it that are non-arbitrary and objective.
It really just seems like there's no truth of the matter in such disputes.
There's no right answer to the question: "__what__ does this software do?"

### Function

At this point, it's tempting to reach for the "it's an art not a science"
response:

> The SRP isn't perfect. It's just a rough guideline. You're not going
to get anything rigorous -- nor should you expect something rigorous -- because
software engineering is an art. Just as there isn't a rigid formula for what
combinations of paint will look good on a canvas, there isn't a formula for
when you've put too much functionality into a class.

Until recently, I felt that this was the real take-away from the SRP. But now I
think it gives up too fast.

Scientists face the same conceptual problems that software
developers do. Consider the heart. What does it do? On one hand, it seems
that it pumps blood. On the other, it makes a thumping noise. But only the
former constitutes the __function__ of the organ -- __what__
it does, its purpose, the reason it's there. The thumping is simply a side
effect: part of __how__ it functions.

Notice how similar this is to our problem above? Biologists, like programmers,
have a maddening tendency to adopt anthropomorphic metaphors when they speak.
"The purpose of the heart is to pump." As if hearts can think, and act
intentionally! Note too the similarity to Martin: "Pumping is the single reason
we have a heart". And then there's also the problem of differentiating how from
what: is the thumping part of the __how__ or the __what__?

Should we conclude that biology is an art and not a science?

No, we shouldn't. This problem can (and is) solved by appeal to [natural
selection](https://en.wikipedia.org/wiki/Natural_selection). Natural selection
in its rough form has three tenets:

1. organisms possess different versions of the same traits
2. different versions of the same traits confer differing fitness levels on
   organisms: i.e. having certain versions of the traits increases an organism's
   propensity to survive and have offspring, while having others decreases it
3. traits are heritable, i.e. they are passed down from one generation to
   the next

The function of an organ -- or anything -- in biology is
[the behavior which accounts for its being selected for](https://mechanism.ucsd.edu/teaching/w10/wright.functions.%201973.pdf).
The pumping behavior of the heart, and not its thumping, accounts for its being
selected for. Hence, the heart's function is to pump. The pumping, and not the
thumping, is thus the purpose of the heart. It is the sole reason we have a
heart.

Can we apply this to software?

I think we miss something important if we don't point out the similarities that
digital systems (code-bases) have with living systems (organisms). Organisms have
generations, each successive member of which with slightly different properties
than that before it. Those properties which are selected for by the environment
appear more readily in the next generation. Codebases, alternatively, have
iterations. Each successive iteration has slightly different
properties(functions, classes) than that before it. And here too, the change in
properties over time is a function of the environment: market forces, what
users liked, what they complained about, what competitor products did, etc.

So we can ask of parts of code-bases what we asked of parts of organisms: what
behaviors account for their being selected for? Why didn't we just delete this
class last month? What keeps this around?

Surely this is a question that we can answer.
