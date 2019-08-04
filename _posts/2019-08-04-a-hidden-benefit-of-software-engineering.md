---
title: A Hidden Benefit of Software Engineering
tags: general programming
excerpt: Software engineering jobs are even better than you think
---

My grandfather tells this story about a paper warehouse he worked in, and about
how he had worked in this warehouse for so long that at some point he was the
only person who knew how to identify all of the different kinds of paper that
they sold. He would brag that his manager wanted to fire him but
couldn't, because he had made himself nearly invaluable to the company:

> The manager would come over and say, 'Hey, what kind of paper is this?' And I would
rip a piece off and lick it and then tell him what it was. And he'd shake his
fist at me and he'd say, 'You son of a b&%$#!' because he knew I was pulling his
leg. But there wasn't anything he could do about it.

He was the only one who knew
what was what. And unless the company wanted to shut the whole warehouse down
and not sell anything while they tried to track down all of the separate
manufacturers over all the years and get them into the warehouse to tell them
what was what, they were stuck with him.

My grandfather tells great stories. I should be clear that I have no idea if
they are true.

But even if they aren't, this story illustrates a special relationship some
lucky employees _definitely_ have with their employers -- one which is extremely
advantageous, gives them great job security, and affords them particularly strong
leverage in negotiations.
Let's call employees who have this kind of relationship
_invaluable_ employees.  They are, roughly speaking, employees who -- for
whatever reason -- bring value to their employers well beyond what other
comparably qualified people would otherwise bring to their positions, which is
to say: their value relative to replacement is extremely high. If his stories
are true, my grandfather full took advantage of this situation. But that is
not why I bring this up.

I bring this up to point out something which I think is seldom noted, which is
that most software engineering positions have an extremely high likelihood of
producing invaluable employees in exactly this sense.

Most people are familiar with the term "10x engineer" and the rule that "it
takes 6 months before an engineer can be productive at a new job". I think both
actually point to the same reality, which is that when you are working as a
software engineer there is a ton of business-specific knowledge that you need to
know in order to do your job. Knowledge like: that there are _these_
background processes that need to run on these machines for this service to
work, and -- oh -- we don't use EC2 machines because we tried and _this_
happened, and you deploy this process like this but _that_ one you have to
deploy like that because if you deploy it the other way then DEAR GOD it took us
days to clean up the mess, and you can't save this record too often because each
time you save it we fire off this webhook which we also consume in this job and
if it gets too far behind then it slows the whole system down, and you
provision servers like this, and you run
migrations like this, and you run tests like this, and you lint like this, and
you version like this, and
you never change this file because of the metaprogramming going on here, here,
and here that some guy wrote before he left that he didn't have tests for but it
works well so we all just leave it alone, and -- oh yeah -- that test is just
flaky so you can ignore it, and you always have to remember to let this team
know after you touch this file because they'll need to kick off a new build
first, and on and on and on, basically forever.

The point of that long, run-on sentence is that there are large
numbers of things you just need to know in order to do most software engineering
jobs that other engineers, even otherwise comparably trained and equally
knowledgeable engineers, could not ever _possibly_ know. Even an experienced,
talented engineer coming into a place with a minimally well-established
engineering culture is effectively _crippled_ by the lack of domain knowledge.
They get nothing substantial done _for months_ -- 6 months
apparently. No one even expects them to. How
could they, not knowing all these things? Compared to them, the people who have
been around for even just a couple years are all "10x engineers", superheros,
gods of the machines. The value of these 10x engineers simply cannot be
overstated. You can't _get_ other people like them. You hire new people, and they
just don't compare -- not for a _long_ time. And who stays at any
company for a long time these days? The value of the 10x engineer (relative
to replacement) is extremely high. Really, we should just say they are
*invaluable* engineers. Make sure you keep them happy. Do whatever it takes.

There are so many great benefits of being a software engineer that we all know
about: good pay, good benefits, cool offices, an abundance of jobs, great job
prospects for the foreseeable future, the ability to work from anywhere, allows
for substantial creativity, is intellectually engaging and rewarding, etc.

Add to that one more: that if you stick around long enough, you tend to
become an invaluable employee.
