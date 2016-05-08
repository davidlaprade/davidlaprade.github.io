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
just short for other things that we could have said instead. But sometimes
these anthropomorphic metaphors can be unhelpful, as they mask what we really mean.

It strikes me as anthorpomorphic to describe code as having a "reason
to change". Code doesn't literally have reasons (to change, or to anything)
because it doesn't think. It's text in a
file. It has no mind, intentions, desires, wishes, hopes, dreams -- nor any of
the things necessary to have reasons for anything: for getting ice cream, for
going to the gym, for writing more code, for changing code, etc.

So, anthropomorphism aside, what I think Martin must have meant is this:

> _Programmers_ should only have one reason to change a class.

Okay, that's better. Progammers definitely have reasons for changing code.
But now here's the problem. This is literally never true. Here are some reasons
a programmer might have to change _any_ class:

* it contains a bug
* it can be refactored so that its easier to read
* the language that it's written in has deprecated one of its methods
* it can be refactored so that its faster, more memory efficient
* it or its methods weren't named as perspicuously as they could have been
* the programmers have decided to follow a new style of programming, and this
  code follows a different style
* a boss demands that it be rewritten because he thinks its too confusing to
  explain to the CEO

And so on. Now, it should be clear that the reasons above are completely
general: they apply to any piece of code. Any code might have a
bug, and thus a programmer would have a reason to change it. Any code might
become deprecated, and thus a programmer would have a reason to change it. Any
code might have a faster implementation, and thus a programmer would have a
reason to change it. And so on.  So, if Martin's quote is taken as an
adequate statement of the SRP,
then the SRP is literally not possible to ever abide by. No matter what anyone
writes, it has more than one "responsibility" -- more than one reason to change.

This seems like it's missed Martin's point. But why?

Distinction: what code does vs how it does it. Martin's saying there should only
be one reason to ever change what the code does, not how it does it.
