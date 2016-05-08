One famous imperative of object oriented programming goes like this:

> A class should have only one reason to change.

This quote, due to Robert Martin, is an attempt to express what is
known as the ["Single Responsibility
Principle"](https://en.wikipedia.org/wiki/Single_responsibility_principle),
or "SRP" for short, the (rough) idea that programmers should limit what certain
units of code can do.

Many people take Martin's statement of the SRP as incredibly clear,
illuminating, insightful, even profound. But I find it
unclear and unhelpful. I should stress that I
definitely _do_ think that there is some imperative that programmers should
follow that limits what units of code can do (i.e. the SRP).
What I debate is whether Martin's quote is an
adequate statement of that imperative. I also suspect that most of the
competent programmers who endorse Martin's statement of SRP simply have
a connoseur's ability to ignore the unintersting reasons why code should change
-- that, or, they haven't actually thought about it carefully.

So, let me explain why I think the quote is unclear.

First, because it's
[anthropomorphic](https://en.wikipedia.org/wiki/Anthropomorphism). From
wikipedia:

> Anthropomorphism is the attribution of human traits, emotions, and intentions
  to non-human entities

Discussions of code design/architecture are often maddeningly anthropomorphic.
We don't talk about where code should be written within a directory structure,
instead we talk about where code should "live". We don't talk about what
informaton is embedded within the code, we talk about what the code "knows".
We say that some code "talks" to other code, we say that we should "ask" certain
peices of code certain things, and not "tell" them. And on and on.
But code is just
text: nothing more. It doesn't live anywhere, it doesn't know anything, it
doesn't talk, ask, tell -- not _literally_ anyway. When we say these
anthropomorphic things, we know they are just metaphors. We know they are really
just short for other things that we could have said instead. But sometimes
this insider-language masks the fact that we really don't know what we're
talking about at all. This makes it dangerous.

It strikes me as similarly anthorpomorphic to describe code as having a "reason
to change". Code doesn't literally have reasons (to change, or to anything)
because it doesn't think. It's text in a
file. It has no mind, intentions, desires, wishes, hopes, dreams -- nor any of
the things necessary to have reasons for anything: for getting ice cream, for
going to the gym, for writing more code, for changing code, etc.

What I think Martin must have meant is this:

> Programmers should only have one reason to change a class.

Okay, that's better. Progammers definitely have reasons for changing code.
But now here's the problem. This is literally never true. Here are some reasons
a programmer might have to change _any_ class:

* it contains a bug
* it can be refactored so that its easier to read
* the language that it's written has deprecated one of its methods
* it can be refactored so that its faster, more memory efficient
* it or its methods weren't named as perspicuously as they could have been
* a boss demands that it be rewritten
* the programmers have decided to follow a new style of programming

And so on. Now, it should be clear that the reasons above are completely
general: meaning that they apply to any piece of code. Any code might have a
bug, and thus a programmer would have a reaosn to change it. Any code might
become deprecated, and thus a programmer would have a reason to change it. And
so on.  So, if Martin's quote is taken as an adequate statement of the SRP,
then the SRP is literally not possible to ever abide by. No matter what anyone
writes, it has more than one "responsibility" -- more than one reason to change.

As I said above, I think there is a legitimate SRP: there is some imperative
that programmers should follow that limits what units of code can do.
I conclude, then, that Martin's quote simply is not an adequate statement
of the SRP.
