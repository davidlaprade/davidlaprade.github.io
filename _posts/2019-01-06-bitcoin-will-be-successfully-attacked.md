---
title: "Bitcoin Will Be Successfully Attacked"
date: "2019-01-06"
tags: bitcoin crypto
excerpt: "Why I think that the Bitcoin network will eventually be successfully
attacked."
---

_DISCLAIMER: At the time of writing, I own bitcoin. I don't approve of or condone
attacks on the Bitcoin network. I am not a financial advisor
and this is not financial advice. Do your own research and consult with a
qualified professional before investing._

### TLDR

I think that the odds that Bitcoin will be successfully attacked are exceedingly
high. My argument is very simple:

* the Bitcoin core software has to continue changing indefinitely
* each change adds a non-zero chance of catastrophic failure
* after enough changes, the probability of an exploitable bug
  approaches 100%; it is now ~99.5% even under conservative assumptions

### To The Moon

![to the moon reddit meme]({{ site.baseurl }}/jekyll_img/to-the-moon.jpg)

Back in 2013 someone posted an image (above) of Bitcoin's rising price on Reddit with
a title of ["To the moon"](https://www.reddit.com/r/Bitcoin/comments/1p2o9g/to_the_moon/).
It stuck, and since then the phrase "to the moon" has become an
extremely well-known idiom in the cryptocurrency community. It means, roughly,
"hooray, price increases!"

Though at the time the phrase was meant to just be funny/silly,
it recently struck me how oddly fitting it is.

The Bitcoin project is a whole lot like the NASA
project, Apollo, that sent men to the moon.

Each attempted something novel, audacious, even crazy: a man on the moon,
trustless money. Each pushed the limits of its respective science and
technology. Each has had (or looks to have) important, positive political
ramifications.

But they are also similar in other ways -- ways that I think have important
implications for the future of Bitcoin, and digital currencies generally.

### Critical Decisions

When you are trying to send someone to the moon, you need to make a large number
of critical decisions. Decisions like:

* what fuel to use
* how much oxygen to send
* how to insulate the cabin
* what weather to launch in
* what trajectories to take
* what orbit to occupy
* what material to re-enter with
* what computers to install
* what programs to write

And so on. Just to give an obvious, off-the-cuff, high-level list.

All of these are _critical_ decisions, meaning that each has the potential to
sink the project. Get just *one* of them wrong -- send too little oxygen,
insufficiently insulate your cabin, cross your wiring, botch your orbitals,
put a bug in your launch algorithms -- and you have a catastrophic failure.
The success of the mission depends on not one but on all of these things
being right _at the same time_.

Devin Kipp, a Systems Engineer on NASA's recent InSight mission, recently put
this well:

> We tested the radar by flying on a helicopter. We tested pieces of the heat
> shield by putting them in an arc-jet facility. We tested the parachute by
> testing it in a wind tunnel. And putting all that together in a very tightly
> controlled sequence where every single thing has to go right, we've never
> tested that, and the first time it's going to happen is when you deliver us to
> Mars. [[Ref](https://youtu.be/bGD_YF64Nwk?t=1827)]

Why does this matter?

### Conjunction Rule of Probability

The [Restricted Conjunction Rule of
Probability](https://academic.csuohio.edu/polen/LC9_Help/9/93rcr.htm) says that
the probability that a set of independent events _a, b, c,
... , n_ will all occur can be expressed as follows:

> Pr(a & b & c & ... n) = Pr(a) x Pr(b) x Pr(c) x ... x Pr(n)

Thus, the probability of success of a space mission is no greater than the
product of the probability of each of its critical decisions. If the probability
that your wiring is correct is only 50%, then _at best_ the
probability that the entire mission will succeed is 50%. Even if you have 100%
confidence that each of the other ten thousand critical decisions has been made
correctly (which you won't), the mission would still be a 50:50 operation. A
coin toss.

Put another way: suppose you had 99% confidence that each of 200 critical
decisions you made on a project were correct. What would be the probability
that the project on the whole would be successful? Well, using the formula
above:

> Pr(project success) = 0.99 x 0.99 x ... (repeat 197 times) ... x 0.99

Or, more simply:

> Pr(project success) = 0.99 <sup>200</sup> = 0.133979675

In other words, you would still only have a 13.4% chance of success.

### Bitcoin Decisions

The same holds true for Bitcoin. Decisions constantly need to be made by
the core developers. Decisions about how to:

* fix bugs
* improve performance
* tighten security
* support new hardware
* support new operating systems
* enable scalability
* patch existing vulnerabilities
* update dependencies

And so on. And, insofar as each of these changes could introduce a fatal bug
into the system, they each constitute a _critical_ decision.

__The success of Bitcoin, then, is likewise dependent on not one but on all of a
long series of difficult decisions being right _in perfect succession_, and
without exception.__

How many difficult decisions? At the time I am
writing this, Github -- where bitcoin has been versioned since
[2009](https://github.com/bitcoin/bitcoin/commit/4405b78) -- lists [6,886 merged pull
requests](https://github.com/bitcoin/bitcoin/pulls?utf8=%E2%9C%93&q=is%3Aclosed+is%3Apr+is%3Amerged) on the project.
Obviously not all of these represent _critical_ changes. Filtering out changes
tagged as `tests`, `questions`, `help`, and `docs`, we're left with
[5,339](https://github.com/bitcoin/bitcoin/pulls?utf8=%E2%9C%93&q=is%3Aclosed+is%3Apr+is%3Amerged+-label%3ATests+-label%3A%22Questions+and+Help%22+-label%3ADocs).

Suppose we have 99.9% confidence that each of these 5,339 changes did not
introduce a serious bug. This would be incredibly high confidence given the
track record of most software developers (more on this below). Even so, by the formula above:

> Pr(BTC does not contain a serious bug) = 0.999 <sup>5,339</sup> = 0.004787862

That's less than a 0.5% chance that BTC does not currently contain a serious
bug. And that doesn't even include the changes made before BTC was versioned on
Github. Nor does it include any changes that made it onto master without
merging, e.g. rebased PRs, branches that were merged without a PR, or commits
directly to master. The point is: this is a _conservative_ estimate.

Even worse: each time more changes are made, this number _decreases_.

This bears emphasizing, because Bitcoin cannot remain a static project: it has
to continue to change in _perpetuity_, for as long as it exists.

### The Inevitability of Change

It might not be obvious why Bitcoin has to continue to change. If it's so risky
to make changes, why couldn't we just freeze the code at some point and halt
development altogether?

Here are a few reasons.

1. __Performance__. The network cannot
currently handle anything close to the [transaction volume needed for
wide-spread use](https://twitter.com/yassineARK/status/1032353127800991750).
More and more [disc space is required to run a full
node](https://www.reddit.com/r/btc/comments/7gwe0d/how_much_disk_space_is_needed_for_a_full_node/),
which eventually will become prohibitively large. Issues like these, and others,
will need to be resolved if Bitcoin is going to achieve its dream of wide-spread
adoption and use.

2. __Security__. New attack vectors are
constantly being created. Very likely there are bugs in the core software
that we just aren't aware of. There may well be game-theoretic issues with Proof of Work
that we can't currently imagine, or vulnerabilities [in the language C++
itself](https://gcc.gnu.org/bugzilla/buglist.cgi?bug_status=ASSIGNED&cf_known_to_fail_type=allwords&cf_known_to_work_type=allwords&component=c&component=c%2B%2B&product=classpath&product=gcc&query_format=advanced).
Super-efficient mining chips might be developed that make a 51% attack
achievable.
Techniques might be invented to engineer [SHA256
collisions](https://security.googleblog.com/2017/02/announcing-first-sha1-collision.html)
and silently rewrite important blocks in the chain.
Quantum computers might someday [be able to brute force private keys from public keys](https://en.wikipedia.org/wiki/Post-quantum_cryptography).<sup>1</sup>
Etc.

3. __Change Elsewhere__. Bitcoin core contains [a lot of
dependencies](https://github.com/bitcoin/bitcoin/search?l=C%2B%2B&q=include).
As these dependencies themselves update (to fix bugs, improve compatibility,
etc.) the core Bitcoin software will need to update as well. New operating
systems will continue to be written that people will want to run nodes on. Etc.

For these reasons, the core Bitcoin software needs to be under active
research and development forever. And inevitably this means research
and development by fallible humans -- the kind that routinely introduce bugs.

Eventually, everyone makes a mistake. Even the smartest people, even
[geniuses](https://en.wikipedia.org/wiki/Russell%27s_paradox).
Even when they are following best practices. Even when they are
perfectly well-intentioned. Even when no one is trying to make them fail.

### Probabilistic Time Bomb

This has been my argument so far:

1. Bitcoin has to continue changing for as long as it is in existence.

2. Each change to Bitcoin has a non-zero chance of introducing a serious bug
   that will be exploited.

3. Hence, if Bitcoin is around for a long time, it is virtually certain that at
   some point a very serious bug will be introduced and exploited. [from 1, 2, by
  the Conjunction Rule of Probability]

Bitcoin is, in other words, a kind of probabilistic time bomb.

But wait: surely this can't be right. _Every system_ is like bitcoin in these
respects: every system has to continue to change if it is going to continue
working, and every change compounds its risk of failure. And yet, it doesn't
seem like these other long-running systems are blowing up all around us. So, why
should we be concerned about Bitcoin?

Actually, other long-running systems _absolutely are_ blowing up all around us.
Serious bugs are deployed and exploited _all the time_. Just some recent
examples:

* Facebook's chronic data breaches:
  [exposing the login tokens of 50+ million
  users](https://newsroom.fb.com/news/2018/09/security-update/), which could be
  used to sign into any service that had a "login with Facebook" option, losing
  the personal information of another [87 million users to Cambridge
  Analytica](https://www.theguardian.com/technology/2018/apr/08/facebook-to-contact-the-87-million-users-affected-by-data-breach), etc.
* Google was hacked to the tune of
  [100+ million of Gmail passwords in 2016](https://www.dailymail.co.uk/sciencetech/article-3573203/Big-data-breaches-major-email-services-expert.html),
  and [lost the personal information of 500k+ people on its Google+ network](https://www.cbsnews.com/news/google-data-exposure-unreported-affects-hundreds-of-thousands-2018-10-08-live-updates/) between 2015 and 2018
* [Apple's iCloud hack](http://time.com/3247717/jennifer-lawrence-hacked-icloud-leaked/)
  of personal photos of celebrities in 2014, and the recent (2019) [FaceTime
bug](https://9to5mac.com/2019/01/28/facetime-bug-hear-audio/) that allowed people to activate the microphone of those they were calling before they picked up
* a Twitter bug [exposed the passwords of its 330 million users in plain
  text](https://blog.twitter.com/official/en_us/topics/company/2018/keeping-your-account-secure.html) in 2018
* Netflix had its [users' account credentials stolen in
  2015](https://www.independent.co.uk/life-style/gadgets-and-tech/news/netflix-hacked-recently-watched-fix-a6759336.html)
and saw some of its new series [swiped in
  2017](https://www.nytimes.com/2017/04/29/business/media/netflix-hack-orange-is-the-new-black.html)
* an Equifax [bug](https://www.wired.com/story/equifax-breach-no-excuse/) enabled a [data breach](https://www.consumer.ftc.gov/blog/2017/09/equifax-data-breach-what-do)
exposing sensitive information (names, addresses, social security numbers) of 143 million people
* Yahoo had [3 billion users' account information stolen](https://www.oath.com/press/yahoo-provides-notice-to-additional-users-affected-by-previously/) by a malicious party in 2013
* Knight Capital [lost $440 million in 45 minutes](
https://en.wikipedia.org/wiki/Knight_Capital_Group#2012_stock_trading_disruption)
because of a misused _feature flag_ in their trade executor code in 2012
* Ebay lost [145 million users'
  information](https://www.washingtonpost.com/news/the-switch/wp/2014/05/21/ebay-asks-145-million-users-to-change-passwords-after-data-breach/) to a bad actor in 2014

Take a look at the names on that list: Google, Apple, Facebook, Twitter,
Netflix, Yahoo, Ebay. These are the tech _giants_. They employ many of the best
engineering minds in the world. They have obscene research budgets. And yet they
release bug after bug after bug. For an even more complete list, see
[this](https://en.wikipedia.org/wiki/List_of_data_breaches).

And we've already seen [serious bugs make it onto Bitcoin's production
network](https://medium.com/@awemany/600-microseconds-b70f87b0b2a6) -- bugs that
could have been used to mint an unlimited supply of coins. That exploit was
fortunately prevented before any bad actors discovered it. To date, we have
not seen a successful exploit of the Bitcoin network (not since it has risen in
value and prominence). But the point still stands: every day Bitcoin marches
closer to its probabilistic destiny.

---

1. From [wikipedia](https://en.wikipedia.org/wiki/Post-quantum_cryptography): "As of 2018, [. . .] the most popular public-key algorithms
   [. . .] can be efficiently broken by a sufficiently strong hypothetical quantum
computer. The problem with currently popular algorithms is that their security
relies on one of three hard mathematical problems: the integer factorization
problem, the discrete logarithm problem or the elliptic-curve discrete logarithm
problem. All of these problems can be easily solved on a sufficiently powerful
quantum computer running Shor's algorithm."

