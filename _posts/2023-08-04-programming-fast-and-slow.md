---
title: "Programming, Fast and Slow"
tags: programming
date: "2023-08-07"
excerpt: "There are two modes of programming analogous to Kahneman's famous modes of thinking."
---

Kahneman [famously
distinguished](https://en.wikipedia.org/wiki/Thinking,_Fast_and_Slow) between
two different modes of thinking:

* type 1, or "fast" thinking
* type 2, or "slow" thinking

The former is the kind of thinking that's automatic, low-effort, instinctual. It
can be done while driving a car. When you decide what to do about a lion
crouching nearby, you're exhibiting type-1 thought.

Type-2 thinking, by contrast, is intentional, high-effort, and cannot be done
while multitasking. When you try to multiply 17 * 23 in your head, you're
exhibiting type-2 thought.

I think there are two analogous [[0]](#footnote0) modes of programming:

* type 1, or "fast" programming
* type 2, or "slow" programming

Type-1 programming, like type-1 thinking, is for situations that demand fast
responses, where the risk of responding too slowly outweighs the risk of
responding sub-optimally. Stated in terms of the [Pareto
Principle](https://en.wikipedia.org/wiki/Pareto_principle), type-1
programming seeks to exert 20% of the effort while producing 80% of the value.
[[1]](#footnote1)

Type 2 programming, like type-2 thinking, is for situations that demand
accuracy, precision, and correctness; where the cost of error is higher than the
cost of time. This kind of programming seeks to provide _the_ solution to
problems: to do things "the right way".

I often find myself having to jump between these two modes. When I do, it’s kind
of like throwing a switch in my brain. All my habits change.

If I’m doing type-1 programming, I tackle a problem by immediately
writing code. I’m probably not sketching out a design, I’m following my
instincts. I’m probably only writing a few tests, and even then only after
things already work, and probably only for the most important edge/use cases. If
there are open-source libraries I could apply, it’s very likely that I’m going
to use one. And if I try a library and it doesn’t work right away, I’m probably
going to just move on to another. Little point spending the time to figure
things out if I can find something that just works.

If I’m doing type-2 programming, I’m definitely starting by writing things down.
I’m investigating different solutions, I’m circulating my designs for feedback,
I’m checking for blindspots and biases. It’s a given that I’m writing tests,
maybe even first. Coverage is going to be high. Maybe I use a library, maybe I
don’t. Libraries make trade-offs and I might not like them. If I’m going to be
using a library I’m probably going to make a heatmap of the different options
and pick what’s optimal. If the best library isn’t working, I’m reading the
source code to find out why.

If you’ve been an engineer for a while, and worked in a bunch of different
business contexts, you probably know what I’m talking about. Your habits might
be different than mine, but you probably know how it feels to shift gears between the
two types. It’s especially obvious when you’re switching from a job that
requires little/no type-1 programming to one that does.

When I worked at Stripe, nearly all of the programming I did was type-2.
That’s because nothing I did was existential for the business. The company
wasn’t going to go under if I didn't ship my features. The company could afford
for me to go slow, to do things right. It could afford to let me research the
heck out of a problem, get tons of feedback on design/architecture, and go
incredibly deep. It also _needed_ to afford this, because Stripe has a
reputation to protect. The cost of not doing things right could have been massive –
much higher than the cost of doing nothing at all. The only times I was ever in
type-1 mode was during incidents: when something was wrong in production and we
had to stop the bleed asap. It was a relatively rare occurrence.

I currently work at a [startup](https://joinatlas.ai/). And a lot (though not
all) of what I’m doing is type-1 programming. That's because tons of problems
are existential for us. If we don't ship a feature fast enough, the company
might just be dead. There usually isn't time to research what we’re doing for 2
weeks, write out a few design docs, circulate them, incorporate feedback, and
then write immaculate code. We’ll never keep up with our competitors or keep our
customers happy if we do that.

I think it's worth distinguishing these types of programming because some
engineers struggle to make the switch between them, and this can meaningfully
determine the kind of company and role at which they can be successful.

I've worked with engineers who seemed constitutionally incapable of type-1
programming. They just couldn't get past their architectural patterns, their
design docs, their need to go really deep. It made them visibly uncomfortable to
[stop at 20%](https://austinhenley.com/blog/90percent.html).

I've also met engineers who _only_ seem capable of type-1 programming. It hurts
them to go really deep, it’s painful for them to try to find _the_ solution to a
problem. They want to think about stuff, but only so much. They move fast
because they only want to go fast. Anything else is tedious, boring.

Some people can do both. And I think that’s what you really need at a startup. A
lot of what you do at a startup doesn’t differentiate you. Your design, your
hosting, your docs, your splash page. That can probably all be done with type-1
programming.

But the really important stuff – your differentiator, your technical moat – is
going to take type-2 programming. It’s going to need to be good. You’re going to
[have to go deep](
https://www.airplane.dev/blog/how-to-build-a-technical-moat-for-your-product).
You’re going to need to solve your core problem better than anyone else.

Each mode has its place.

<br>

---

### Footnotes

<span id="footnote0">[0]</span>
These modes of programming are analogous, though not reducible, to Kahneman’s
modes of thinking. Programming -- of any sort -- is quintessentially type-2
thinking. You can't do it while driving a car, it takes considerable effort, it
requires intense focus, etc.

<span id="footnote1">[1]</span>
Type-1 programming should not be confused with sloppy or bad programming, or
programming that produces technical debt. Like anything, it can be done well or
poorly, with better or worse abstraction, etc. This could easily be it's own
blog post.
