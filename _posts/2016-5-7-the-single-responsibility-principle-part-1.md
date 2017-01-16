---
title: "The Single Responsibility Principle, Part 1"
tags: architecture
excerpt: "How I fail to understand it and you can too."
date: "2016-05-19"
---

_NOTE: this is the first of a two part series on the Single Responsibility
Principle._

The [Single Responsibility
Principle](https://en.wikipedia.org/wiki/Single_responsibility_principle),
or SRP for short, is the claim that programmers should limit what certain
units of code can do. It says: "don't make the basic bits of your code do too
much!" It's a good principle, and just about everyone agrees.

But the SRP in its uncontroversial form is a very "high level" claim: it gives
little by way of specific instructions. What are the units of code we should
limit? How do we know when those units are doing too much? In other
words, it remains an open question just what specifically the SRP consists in.

### Bob's Your Uncle

The most famous attempt to say what the SRP amounts to comes from
Bob Martin, AKA [Uncle Bob](https://en.wikipedia.org/wiki/Robert_Cecil_Martin)
who coined the term "Single Responsibility Principle". He puts it like
[this](https://blog.8thlight.com/uncle-bob/2014/05/08/SingleReponsibilityPrinciple.html):

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

Martin knows this. He
[clarifies](https://blog.8thlight.com/uncle-bob/2014/05/08/SingleReponsibilityPrinciple.html):

> Certainly the code is not responsible [. . .] Those
things are the responsibility of the programmer, not of the program.

A ha! So, Martin meant this:

> Programmers should only have one reason to change a class.

Okay, that's better. Progammers definitely have reasons for changing code.
But now here's the problem. This is literally never true. Here are some reasons
_any_ programmer might have to change _any_ class:

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

Martin anticipates this objection in his
[article](https://blog.8thlight.com/uncle-bob/2014/05/08/SingleReponsibilityPrinciple.html):

> Some folks have wondered whether a bug-fix qualifies as a reason to change.
Others have wondered whether refactorings are reasons to change. [. . .]
remember that the reasons for change
are people. It is people who request changes. And you don't want to confuse
those people, or yourself, by mixing together the code that many different
people care about for different reasons. [. . .] When you write a software
module, you want to make sure that when changes are requested, those changes can
only originate from a single person[.]

Martin seems to be saying that the examples above are not actually "reasons
to change" -- not in the sense that he meant the phrase. It seems from this
clarification that he actually meant something like this:

> For any given class that a programmer writes, there should be no more than one
person who can justifiably request a change to it

I found this idea really exciting. It's certainly
a completely different way of thinking about how we should break up bits of
functionality within software. And it makes a lot of sense!

But I don't think it solves our problems.

Just consider a class that has a bug in it. Who __wouldn't__ be justified in
requesting that we change this code? The CTO would. The CEO would. The marketing
department would. A fellow developer would. The intern would. Really,
_anyone_ would. But surely it doesn't follow _just from that_
that our class has multiple responsibilities, right?

Or what about people with overlapping responsibilities. Suppose the marketing
director and sales director at a company share the responsibility of determining
prices/discounts/promotions. And suppose I have set aside a single class to
handle promotions. Have I violated the SRP? If we take Martin at his word, then
yes.

Or what about this class:

{% highlight ruby %}
class PaymentEmailService
  def charge
    customer = Stripe::Customer.retrieve(@stripe_id)
    customer.charge(@amount)
  end

  def email
    CustomerNotifier.welcome_email(@email).deliver
  end
end
{% endhighlight %}

Suppose I write this class at the company I just started. I'm the only employee.
No one other than me can (within the authoritative structure of my company)
justifiably request that I change this class. But surely it doesn't follow
__just from that__ that the class has only one responsibility, right? It seems
pretty clear that this has multiple responsibilities.

I recently found a talk where Martin addresses exactly this issue. [He
says](https://youtu.be/Gt0M_OHKhQE?t=733):

> [T]he Single Responsibility Principle says any module should be
responsible to only one person. Now, that's a slightly
confusing statement because -- what if you're the only guy? What if you're the
guy who reads the report and judges the business rules? Does that now mean
that [you] can now
cram all that stuff into one module? No, because even though you're one guy,
you're playing multiple roles. You have the role of the business decider and you
have the role of the report consumer. So the Single Responsibility Principle
really says that a module should be responsible to one and only one role,
regardless of how many people are actually implementing that role.

It's at this point that it really starts to feel like the problem is
just getting pushed back. Where once we had the problem of determining when
a unit of code did too much, now we have the problem of determining just
what "roles" there are for a person or multiple people to occupy. If this new
problem were any more tractable than the former, I'd have no complaints. But,
it isn't.

I'll raise just one concern here:
what __granularity__ of role does Martin have in mind? Is "marketer" a role?
What about "content marketer", "technical marketer", "social media
marketer"?  What about "developer"? Is that a role? If so, are "web developer",
"front-end developer", "back-end engineer", "test engineer", "dev ops engineer",
and
"database administrator" roles? What about "Rails engineer", "Cassandra admin",
"NetSuite scripter", "systems architect", "cloud engineer", "cloud systems
architect", "cloud security engineer", "machine learning scientist"?

The point that I'm trying to make here is that there is no limit to the crazy
specific -- or insanely general -- roles we can come up with, __and find__
at existing businesses. And if business roles are the measure of code
functionality, then it seems there is no limit to the flexibility we enjoy in
deciding how much functionality to pack into our classes. Thus, we've discovered
that
the SRP actually gives us no direction whatsoever, because we've found it to
consist in an endlessly malleable rule.

So Martin's clarification, while interesting, seems like a step in the wrong
direction. There's __got__ to be a better way to understand this.

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

This is definitely helpful. It seems like most of my objections above now fall
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
  def full_name
    @full_name ||= "#{@first_name} #{@last_name}"
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
it does only one thing if described from a high enough level. This is the
"granularity" objection all over again. Let's look at a class:

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
question of language: which level are we supposed to speak at? That's
the second issue.

How could one adjudicate between two programmers who disagreed on these matters?
What if one programmer felt that __what__ the `first_name` function did was set
a variable, and
another felt that what it _really_ did was return a string? What if one
programmer thought the `PaymentProcessor` did one thing and another two?
Who would be right and who wrong? Why?

It's not obvious to me that
these questions have answers. Nor is it obvious that there are any rules for
answering them that are both non-arbitrary and objective.
It really just seems like there's no truth of the matter in such disputes.
It seems like there's no right answer to the question: "__what__ does this
software do?" If so, the prospects of getting any rigorous statement of the SRP
look bleak.

### Conclusion

I've tried to show why the Single Responsibility Principle isn't all that clear.
At this point, it's tempting to reach for the "it's an art not a science"
response, like this:

> The SRP isn't perfect. It's just a rough guideline. You're not going
to get anything rigorous -- nor should you expect something rigorous -- because
software engineering is an art. Just as there isn't a rigid formula for what
combinations of paint will look good on a canvas, there isn't a formula for
when you've put too much functionality into a class.

Until recently, I felt that this was the real take-away from the SRP. But now I
think it gives up too fast.

To find out why, stay tuned for part 2!
