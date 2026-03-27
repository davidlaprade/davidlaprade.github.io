---
title: "Sub-Second Rails Tests"
excerpt: "How to write Ruby on Rails tests that run sub-second realtime"
---

I've written [before]({{site.baseurl}}/speed-up-rails-tests) about how to
dramatically speed up Rails tests just by modifying your test suite.

This is great, but has its limits. Tests can only be as fast
as the code that they run. So, at some point it becomes natural to ask how we
can modify our __application__ to improve our tests. This might feel a little
backwards. A little like saying:

> Ask not what your tests can do for your application. Ask what your
> application can do for your tests.

But don't we want our tests to influence the way we write code? What if we could
make our tests run like this?

![fast tests]({{ site.baseurl }}/jekyll_img/fast_tests.png)

The goal of this post is to get you on your way to writing sub-second Rails
tests. And the way I'm going to suggest you can do it is by changing your
applications, not your tests.

The trick is pretty underwhelming. All you have to do is to minimize the runtime
dependencies of your application so that there's as little computational
overhead as possible. Sounds obvious. Now try to do it. Details, as we'll see,
will matter.

### History

The focus on minimizing dependencies to improve performance isn't new.
It's had vocal proponents within the Rails community since at least 2011.

Fans of [Uncle
Bob](https://en.wikipedia.org/wiki/Robert_Cecil_Martin) might remember his
influential talk,
["Architecture: The Lost Years"](https://www.youtube.com/watch?v=WpkDN78P884),
from November of 2011. He talks about how he wrote a Rails
application that treated Rails like an I/O device -- a plugin: an entirely
optional addition to the codebase. He completely
eliminated Rails as a runtime dependency of his core application.

> We try to keep all these business rules decoupled. Here's the whole picture.
> We have some delivery mechanism which talks to the user. [. . .] What's the
> delivery mechanism? I don't care. Might be the web.
> Might be a thick client. Might be a console app. Might be a bunch of web
> services. I don't care. And I want to keep it that way. I don't want to care
> what the delivery mechanism is. I'm going to have the delivery mechanism talk
> to me through a boundary interface [. . .] Notice the direction of
> dependencies. [. . .] There are no dependencies landing on the delivery
> mechanism, which means that [. . .] I can make the delivery mechanism a
> plugin to my application. Think of what that would mean to you. [. . .] That
> would mean you would not have to plug it in. When would you not want to plug
> in your delivery mechanism? When you're running tests. [. . .] How fast do you
> think that's going? [ . . .] There's no web server in there or HTML going
> around in there. All the javascript is going on somewhere else. [. . .] You
> could get your tests very fast indeed.
https://youtu.be/WpkDN78P884?t=20m6s

Just a month earlier, at the Golden Gate Ruby conference in September of 2011,
Corey Haines gave a talk about fast rails tests, where he [said the
following](https://youtu.be/bNn6M2vqxHE?t=15m13s):

> The key to [fast tests] is to take what we already know. So we isolate ourselves from the
> database. [. . .] We might build in-memory objects instead of
> actually saving them. [. . .] We isolate ourselves from third party APIs. [. . .]
> And then we come back and we let our tests cause this pain.
> Instead of putting a band-aid on it, [. . .]
> ask yourself: why is it that my tests take 20 seconds to load up? And there's
> one culprit: Rails. Rails takes a long time to load. [. . .] Why not take the
> idea of isolation and bring yourself all the way one step further? And say:
> what is the biggest third party thing that I'm dependent on? Rails!

So, the result of applying an architecture like the one Uncle Bob describes is a
really, really ridiculously fast test suite. Cool! I'd like that. How do I get
it?

### History

These talks were exciting and provocative. They suggested a radical, new way to
write Rails applications: one which dramatically isolated dependencies on Rails.
The trouble is: how to do it? After all, Rails wants to __be__ your application.
In the [words](https://twitter.com/dhh/status/218740829806792704)
 of David Heinemeier Hansson:

> "Rails is not your application". If you're building a web app, of course it
> is.

Corey Haine's Idea
Problem: How to actually do it?
Separate testing folder
Rails fakes
Debugging: if $test; binding.pry; $test = false; end
Lingering problem: controller filter chain, browser tests

Resources:
* [Corey Haines' talk](https://www.youtube.com/watch?v=bNn6M2vqxHE)
* [Bob Martin's talk](https://www.youtube.com/watch?v=WpkDN78P884)
* [Any Examples?](http://programmers.stackexchange.com/questions/149656/are-there-any-examples-of-uncle-bobs-high-falutin-architecture)
* [Jim Weirich's talk](https://www.youtube.com/watch?v=tg5RFeSfBM4)
* [Jim Weirich's code](https://gist.github.com/dhh/4849a20d2ba89b34b201)
* [DHH's "test induced design damage"](http://david.heinemeierhansson.com/2014/test-induced-design-damage.html)
* [Bob Martin's reply to DHH](http://blog.8thlight.com/uncle-bob/2014/05/01/Design-Damage.html)
* [DHH's gist against Jim's approach](https://gist.github.com/dhh/4849a20d2ba89b34b201)
* [Partial Alternative to Jim's Approach](http://www.patmaddox.com/2014/05/15/poof-and-then-rails-was-gone/)
* [Article on Hexigonal Architecture](http://alistair.cockburn.us/Hexagonal+architecture)
