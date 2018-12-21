---
title: "Will bitcoin go to the moon?"
date: "2018-11-22"
excerpt: My thoughts on the inherent risks of bitcoin.
---

_DISCLAIMER: At the time of writing, I own bitcoin. I am not a financial advisor
and this is not financial advice. Do your own research and consult with a
qualified professional before investing._

![to the moon reddit meme]({{ site.baseurl }}/jekyll_img/to-the-moon.jpg)

### To The Moon

Back in 2013 someone posted an image (above) of Bitcoin's rising price on reddit with
a title of ["To the moon"](https://www.reddit.com/r/Bitcoin/comments/1p2o9g/to_the_moon/).
It stuck, and since then the phrase "to the moon" has become an
extremely well-known idiom in the cryptocurrency community. It means, roughly,
"hooray, price increases!"

Though at the time the phrase was meant to just be funny/silly,
it recently struck me how oddly fitting it is.

**The Bitcoin project is a whole lot like the NASA
project, Apollo, that sent men to the moon.**

Each attempted something novel, audacious, even crazy. A man on the moon.
Trustless money.

Each has been extravagantly valuable. Assuming that the value of the Apollo
missions can be roughly approximated by their cost, a [2015
estimate](https://www.popsci.com/real-cost-nasa-missions#page-2) put the cost of
the Apollo missions at $65 billion dollars per year ($71B adjusted for
inflation) -- not far off from the current [$75 billion dollar market
capitalization](https://coinmarketcap.com/currencies/bitcoin/) of Bitcoin.

They are also similar in other ways -- ways that I think have important
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

The success of Bitcoin, then, is likewise dependent on not one but on all of a
long series of difficult decisions being right _in perfect succession_, and
without exception.

How many difficult decisions? At the time I am
writing this, Github -- where bitcoin has been versioned since
[2009](https://github.com/bitcoin/bitcoin/commit/4405b78) -- lists [6,886 merged pull
requests](https://github.com/bitcoin/bitcoin/pulls?utf8=%E2%9C%93&q=is%3Aclosed+is%3Apr+is%3Amerged) on the project.
Obviously not all of these represent _critical_ changes. Filtering out changes
tagged as `tests`, `questions`, `help`, and `docs`, we're left with
[5,339](https://github.com/bitcoin/bitcoin/pulls?utf8=%E2%9C%93&q=is%3Aclosed+is%3Apr+is%3Amerged+-label%3ATests+-label%3A%22Questions+and+Help%22+-label%3ADocs).

Suppose we have 99.9% confidence that each of these 5,339 changes did not
introduce a serious bug. This would be incredibly high confidence given the
track record of most software developers. Even so, by the formula above:

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
to make changes, why couldn't we
just freeze the code at some point and halt development altogether?

Here are a few reasons.

1. Bitcoin needs to continue to change for performance reasons: the network cannot
currently handle anything close to the [transaction volume needed for
wide-spread use](https://twitter.com/yassineARK/status/1032353127800991750).
More and more [disc space is required to run a full
node](https://www.reddit.com/r/btc/comments/7gwe0d/how_much_disk_space_is_needed_for_a_full_node/),
which eventually will become prohibitively large. Issues like these, and others,
will need to be resolved.

2. It needs to continue to change for security reasons. New attack vectors are
constantly being created. Very likely there are bugs in the core software
that we just aren't aware of. There may well be vulnerabilities in Proof of Work
that we can't currently imagine, or [in the language C++
itself](https://gcc.gnu.org/bugzilla/buglist.cgi?bug_status=ASSIGNED&cf_known_to_fail_type=allwords&cf_known_to_work_type=allwords&component=c&component=c%2B%2B&product=classpath&product=gcc&query_format=advanced).
Super-efficient mining chips might be developed that make a 51% attack practical.
Techniques might be invented to engineer [SHA256
collisions](https://security.googleblog.com/2017/02/announcing-first-sha1-collision.html).
Quantum computers might someday [be able to brute force private keys from public keys](https://en.wikipedia.org/wiki/Post-quantum_cryptography).<sup>1</sup>
Etc.

3. It needs to continue to change because related software is
   changing around it. Bitcoin core contains [a lot of
dependencies](https://github.com/bitcoin/bitcoin/search?l=C%2B%2B&q=include).
As these dependencies themselves update (to fix bugs, improve compatibility,
etc.) the core Bitcoin software will need to update as well. New operating
systems will continue to be written that people will want to run nodes on. Etc.

For these reasons, the core Bitcoin software needs to be under active
research and development essentially forever. And inevitably this means research
and development by fallible humans -- the kind that routinely introduce bugs.

(Move to subscript)
1. From [wikipedia](https://en.wikipedia.org/wiki/Post-quantum_cryptography): "As of 2018, [. . .] the most popular public-key algorithms
   [. . .] can be efficiently broken by a sufficiently strong hypothetical quantum
computer. The problem with currently popular algorithms is that their security
relies on one of three hard mathematical problems: the integer factorization
problem, the discrete logarithm problem or the elliptic-curve discrete logarithm
problem. All of these problems can be easily solved on a sufficiently powerful
quantum computer running Shor's algorithm."

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
  of personal photos of celebrities in 2014
* a Twitter bug [exposed the passwords of its 330 million users in plain
  text](https://blog.twitter.com/official/en_us/topics/company/2018/keeping-your-account-secure.html) in 2018
* Netflix had its [users' account credentials stolen in
  2015](https://www.independent.co.uk/life-style/gadgets-and-tech/news/netflix-hacked-recently-watched-fix-a6759336.html)
and saw some of its new series [swiped in
  2017](https://www.nytimes.com/2017/04/29/business/media/netflix-hack-orange-is-the-new-black.html)
* an Equifax [bug](https://www.wired.com/story/equifax-breach-no-excuse/) enabled a [data breach](https://www.consumer.ftc.gov/blog/2017/09/equifax-data-breach-what-do)
exposing sensitive information (names, addresses, social security numbers) of 143 million people
* Yahoo had [3 billion users' account information stolen](https://www.oath.com/press/yahoo-provides-notice-to-additional-users-affected-by-previously/) by a malicious party in 2013
* Ebay lost [145 million users'
  information](https://www.washingtonpost.com/news/the-switch/wp/2014/05/21/ebay-asks-145-million-users-to-change-passwords-after-data-breach/) to a bad actor in 2014

Take a look at the names on that list: Google, Apple, Facebook, Twitter,
Netflix, Yahoo, Ebay. These are the tech _giants_. They employ many of the best
engineering minds in the world. They have obscene research budgets. And yet they
release bug after bug after bug.

And we've already seen [serious bugs make it onto Bitcoin's production
network](https://medium.com/@awemany/600-microseconds-b70f87b0b2a6) -- bugs that
could have been used to mint an unlimited supply of coins. That exploit was
fortunately prevented before any bad actors discovered it. To date, we have
not seen a successful exploit of the Bitcoin network (not since it has risen in
value and prominence). But the point still stands: every day bitcoin marches
closer to its probabilistic destiny.

### The stakes are high

Pampered as Americans are by the long-term stability of our government and its
[willingness to prop up its financial institutions in times of
crisis](https://en.wikipedia.org/wiki/Federal_takeover_of_Fannie_Mae_and_Freddie_Mac),
I think it's easy to forget what is at stake in a system like Bitcoin -- a
system without a backer. There is no crypto
[FDIC](https://en.wikipedia.org/wiki/Federal_Deposit_Insurance_Corporation) to
appeal to if/when you lose your coins to an exploited bug. There is no customer
service to freeze your account if/when an attack exposes your
private keys. If a someone steals your coins, or destroys the network, or
enables new coins to be silently minted for years and drives prices almost to $0,
that's it: the value you placed in Bitcoin would be gone. There are no good guys
to get it back for you.

This is an inherent difficulty of trying to make money out of software.
Software _breaks_. But we don't think of money as a breakable kind of thing --
especially since most of us store the vast majority of our money in banks. A
dollar bill could be destroyed: burned, shredded, dissolved, whatever. But when
your money is in a bank in good standing with the government, it's basically
indestructible. The bank could get hacked, or robbed, or go up in flames, or
declare bankruptcy. Your cards could get stolen, your credentials could be
leaked, etc.  None of it matters if the bank is FDIC insured.  You still have
your money -- _obviously_ you still have your money: because money is
indestructible, your possession of it as real and objective as the
chair I am sitting in. Banks might keep a record of it, but this is merely the
transient image of a deeper economic reality.

I don't think people often appreciate the import that they give to this picture
of the world, nor the extent to which it effects their lives and
informs their decisions, however implicitly/subconsciously. I wonder: would they
still put all of their money in banks if it wasn't so? Would they use the same
6-character password that they use for facebook as their bank login? Would they
put their life-savings and retirement in intrinsically valuables objects like
precious metals, or fine wines, or works of art, or seeds?
The [bank runs](https://en.wikipedia.org/wiki/Bank_run) of Great Depression fame
suggest

And when Bitcoin is inevitably exploited -- and those who put their trust in it
lose their [life-savings](https://www.reddit.com/r/Bitcoin/comments/772kkf/trying_to_play_it_cool_with_my_life_savings_in/), their [retirements](https://www.reddit.com/r/Bitcoin/comments/7hraxb/401k_to_bitcoin/dqt6jb6/), their [homes](https://www.reddit.com/r/Bitcoin/comments/7kw2l7/just_took_out_a_mortgage_on_my_house_to_buy_btc/)
-- they (and we all) will perhaps for the first time be forced to ask ourselves
just how important this economic picture of the world is.

I have no confidence that, at that moment, this is a picture many of us would be
happy to forsake.



But you can't really destroy $1000 of digitized value.
You could destroy the database -- sure -- and all of its backups. But you'd still
feel like you had that $1000, that it still existed and belonged to you. You'd probably
petition the FDIC to get your money back. And when they wrote you a check, you'd
feel like they hadn't really given you something new so much as re-enabled you
to access what you already had. Value, for us, has become a kind of immaterial
entity.


After all, the concerns above equally well apply to banks' digital systems. And,
of course, banks too get hacked. But when someone gets access to your bank
account

I think it's easy for us to think of economic value as a kind of
objective, mind-independent reality. It's easy to think of economic value as
real, as existing independent of anyone's thinking so.


I want to talk briefly about something I'll call "economic value".

Economic value is what is accessed with or represented by money. A one dollar
bill has a certain amount of economic value. We say that it is _worth_ that
amount. A twenty dollar bill is worth 20 times as much as a dollar.  But these
amounts can and do change. Inflation occurs when a unit of money comes to be
worth less economic value, deflation when it is worth more. A one dollar bill
100 years ago had much more economic value than a one dollar bill  does today.
If one were to take all of the official United States bills and destroy half of
them, each remaining bill would in some sense be now worth twice as much as
before. This is because it would now represent twice as much economic value.

This is a natural way to think of economic value

A dollar bill could be destroyed: burned, shredded,
dissolved, whatever. But you can't really destroy $1000 of digitized value.
You could destroy the database -- sure -- and all of its backups. But you'd still
feel like you had that $1000, that it still existed and belonged to you. You'd probably
petition the FDIC to get your money back. And when they wrote you a check, you'd
feel like they hadn't really given you something new so much as re-enabled you
to access what you already had. Value, for us, has become a kind of immaterial
entity.


Much as I might have this chair -- say -- I also have $1000.


This is an inherent difficulty when you try to make money out of software.
Software _breaks_. We don't think of money as a breakable kind of thing --
especially now that many of us store almost all of our money electronically in
banks' databases. A dollar bill could be destroyed: burned, shredded,
dissolved, whatever. But you can't really destroy $1000 of digitized value.
You could destroy the database -- sure -- and all of its backups. But you'd still
feel like you had that $1000, that it still existed and belonged to you. You'd probably
petition the FDIC to get your money back. And when they wrote you a check, you'd
feel like they hadn't really given you something new so much as re-enabled you
to access what you already had. Value, for us, has become a kind of immaterial
entity.

Because we're talking about money here: a system that
has the potential to store a nontrivial percentage of the world's economic
value.

### Replies

Wait, we already know this happened...

And it's no good pointing out that BTC has tests, or that some of the merges
were _fixes_ to previous bugs. Tests are great. Fixes are awesome. But tests
are limited in scope -- you can't simulate an entire network -- and can very
well ignore important vulnerabilities that no one has thought of yet.
Fixes can introduce new bugs as they resolve old ones.

Nor does it matter that -- up to now -- there is no known vulnerability to BTC.
It's not as if the slate is clean, that the formula resets to 1, that we get to
start anew. There are no clean slates. Old code may have bugs we don't even know
about, as has happened [before](https://github.com/bitcoin/bitcoin/pull/9049).
Old features of the code that are currently unproblematic might become
problematic when new code is added.









### Thoroughness and Care

How, then, does NASA achieve repeated success in the face of such odds?

While I won't pretend to know NASA's special-sauce, I think one thing is clear.
NASA mitigates risk and consistently delivers on projects with a high likelihood
of failure by -- among other things -- being exceptionally thorough and careful.

And that, unfortunately, is where the important similarities between
Bitcoin and NASA projects end.

Because unlike the Apollo missions, which were extremely careful, which employed the
expertise of thousands of highly qualified individuals checking and double
checking and triple checking each other's work, Bitcoin is developed and
maintained by just a small handful of people. As I write,
[587 people](https://github.com/bitcoin/bitcoin/graphs/contributors) have
contributed to the project, though most have done very little.
A better estimate of the number of active, competent bitcoin developers is the
number of people who are members of the
[bitcoin organization](https://github.com/orgs/bitcoin/people) -- since it is these people
who can merge pull requests. There are [28 of
them](https://github.com/orgs/bitcoin/people). For a project worth $75 billion
dollars, that many people feel has the single best chance to be the currency of
the future, this seems completely inadequate.

A good example of the inevitable results of this inadequacy is [this infamous
pull request](https://github.com/bitcoin/bitcoin/pull/9049) from 2016, which
attempted to shave a mere 0.7ms off the block validation process. The PR was
reviewed and [approved by one bitcoin
member](https://github.com/bitcoin/bitcoin/pull/9049#issuecomment-257768800),
though that member [didn't even test the code
himself](https://github.com/bitcoin/bitcoin/blob/600b85bb417295f4d9c7d5b9fd8502f3c8f113e3/CONTRIBUTING.md#peer-review).
[Two](https://github.com/bitcoin/bitcoin/pull/9049#issuecomment-259083061)
[other](https://github.com/bitcoin/bitcoin/pull/9049#issuecomment-259248755)
members verbally approved of the change not long after.  In total, then, the
change was vetted by _just 3 individuals_ before being merged and deployed to
production. It was in production for [2 full
years](https://github.com/bitcoin/bitcoin/pull/9049#event-854593839) before
[someone](https://medium.com/@awemany/600-microseconds-b70f87b0b2a6) realized
that it introduced a bug which, if exploited, could have been used to mint an
unlimited number of new coins.

Most changes to the bitcoin core software have roughly this much (or less)
review before being approved, merged, and released. See for yourself
[here](https://github.com/bitcoin/bitcoin/pulls?q=is%3Apr+is%3Aclosed).

An obvious objection at this point is that the Apollo missions required so many
talented people and so many resources not merely because they were so valuable
but because they were so _complex_. Sending a man to the moon required expertise
and advances in many different domains: in physics, materials, engineering,
mathematics, meteorology, astronomy, etc. It's not so much the
riskiness of the missions that
warranted so many people and so many resources so much as we just couldn't have
done it with fewer people. Bitcoin is nowhere near as complex
as this, so it doesn't warrant nearly the same level of care.

This objection is a good one, but I think it's conflating
thoroughness with carefulness.

The execution of the NASA missions was _thorough_ -- as it involved competent
experts in all of the appropriate fields and addressed all of the major problems
-- but it was also _careful_ -- proceeding slowly, incrementally, with many
practice tests, with operational redundancy, with double-and-triple checks.
NASA, in other words, acted in a manner proportionate to what was at stake:
people's lives, the reputation of the United States, billions of dollars.

Consider, for example, the care that was taken in designing the computer systems
on the [Space Shuttle](https://en.wikipedia.org/wiki/Space_Shuttle):

> Fault tolerance on the Shuttle is achieved through a combination of redundancy
> and backup. Its five general-purpose computers have reliability through
> redundancy, rather than the expensive quality control employed in the Apollo
> program. Four of the computers, each loaded with identical software, operate
> in what is termed the "redundant set" during critical mission phases such as
> ascent and descent. The fifth, since it only contains software to accomplish a
> "no frills" ascent and descent, is a backup. [[Source](https://www.history.nasa.gov/computers/Ch4-4.html)] [. . .]
> The Backup Flight System consists of a single computer and a software load
> that contains sufficient functions to handle ascent to orbit, selected aborts
> during ascent, and descent from orbit to landing site. __In the interest of
> avoiding a generic software failure, NASA kept its development separate from
> PASS [the Primary Avionics Software System, the software that runs in all the
> Shuttle's four primary computers]. An engineering directorate, not the
> on-board software division, managed the software contract for the backup, won
> by Rockwell.__ [Emphasis mine, [Source](https://www.history.nasa.gov/computers/Ch4-5.html)]

Notice the care that NASA took here. Not only did they insist on a 5x
redundancy, but
they even had the code on the 5th machine engineered by a completely separate
group of people. It was an entirely different implementation. All to further
decrease the likelihood that an unknown bug in the system would take them down.

I agree that the complexity of bitcoin means that nothing like the thoroughness
of NASA's execution of the Apollo missions is required. Nevertheless, the
inherent riskiness (as discussed above) -- not to mention the incredible _value_ --
of bitcoin certainly justifies NASA-level _care_. NASA-level care is not
being dedicated to the development of bitcoin.

Some will reply that there just aren't enough qualified developers on the project
to reasonably demand more qualified reviewers.
There aren't PhDs or Nobel Prizes for blockchain science. The field is too
young.

Others will say that BTC just can't afford to move that slowly.

So much the worse for BTC.

And we can't just
_stop_ changing BTC -- both because of performance reasons, but also for
security reasons. Very likely there are other bugs in the core software that we
just aren't aware of. Very likely new technology will emerge (quantum computers?)
that will pose new threats to the system. Very likely new vulnerabilities in bitcoin's
dependencies will be identified (whether in libraries like SHA256, or in elliptic curve
cryptography, or in the language C++ itself).
If for no other reasons than these, BTC core needs to be under active
research and development for the foreseeable future,
it needs to be continually changed by fallible humans.
So long as other hardware and software is changing, it will have to change with it.

Why does this matter? Who cares?

We have on the one hand an inherently risky project that is obscenely valuable.





_Unless you think that 3-5 people can make an endless number of complex
decisions correctly in perfect succession, then you should be
doubtful about the future value of Bitcoin -- and any cryptocurrency._

_0-day bugs_ are software bugs unknowingly introduced into software and deployed to
production.

BTC core has had 0-day bugs.

blog post overview of one of the biggest bugs, by the guy who discovered it:
https://medium.com/@awemany/600-microseconds-b70f87b0b2a6

PR that introduced the bug in 2016:
https://github.com/bitcoin/bitcoin/pull/9049

PR that fixed it in 2018:
https://github.com/bitcoin/bitcoin/pull/14247


From the blog post:
>I always feared that someone from the bankster circles, someone injected into
>the Bitcoin development circles with the sole goal of wreaking unsalvageable
>havoc, would do exactly what happened. Injecting a silent inflation bug. 

> I sometimes do lose some sleep over what could go wrong. I know I make mistakes.
I have done so. I will. We all do.

At the time of writing this, Bitcoin has a $115 billion dollar market cap, i.e.
total cash value.

It seems that pull requests are accepted by BTC core members when 3-5 approve
of them. (Look into this more, maybe get an actual statistic?)

Given that changes to BTC core could introduce a "0-day" bugs like the one
above, you have to ask: is the approval of 3-5 people sufficient for a decision
of this magnitude?

Put another way:
If you really believed you had $115 billion riding on a decision, would you feel
confident if that decision had been made by just 5 people? Even the best,
smartest, most well-informed people?

I wouldn't.

People make mistakes. Catastrophic mistakes. Even the smartest people, even
geniuses.  Even when they are following the best practices. Even when they are
perfectly well-intentioned. Even when no one is trying to make them fail.  (One
thinks of Frege, here -- a epochal genius. See Russell's paradox. See also
Knight Capital,
https://en.wikipedia.org/wiki/Knight_Capital_Group#2012_stock_trading_disruption)

The problem is actually even worse than that. Because you have $115B riding on
not just one decision, but on the conjunction of an _indefinite_ number of decisions.
For as long as
decisions have to be made about how to change BTC, they _all_ have to
be right -- or: wrong-but-fixed-in-time. Get just _one_
decision wrong, and the whole project could be ruined.

And remember, this is a *best-case* scenario. Because, in fact,
bitcoin core developers are not always following best practices (examples?),
bitcoin contributors are not always
well-intentioned (examples?), and powerful people actually are
trying to make the bitcoin project fail (examples?).

Some will reply that there just aren't enough qualified developers on the project
to reasonably demand more
reviewers. Others will say that BTC just can't afford to move that slowly.

So much the worse for BTC.

This just highlights how inherently risky BTC (and all possible cryptocurrencies
) is/are. I say "inherently" here
because this is the nature of software development. The risk can be
mitigated but not eliminated entirely.
It's not possible to remove fallible humans from the process apart from
completely halting BTC development entirely.

And we can't just
_stop_ changing BTC -- both because of performance reasons, but also for
security reasons. Very likely there are other bugs in the core software that we
just aren't aware of. Very likely new technology will emerge (quantum computers?)
that will pose new threats to the system. Very likely new vulnerabilities in bitcoin's
dependencies will be identified (whether in libraries or in the language C++ itself).
If for no other reasons than these, BTC core needs to be under active
research and development for the foreseeable future,
it needs to be continually changed by fallible humans.
So long as other hardware and software is changing, it will have to change with it.

Confidence in the future of BTC thus boils down to this:

* you are confident that a small number of people will make an indefinite string
  of exceedingly complex decisions correctly (or wrong-but-fixed-in-time)

Is it rational to be confident of this? I genuinely don't think it is.

Consider all of the massive mistakes made by the armies of brilliant,
Carnegie-Mellon BA, Stanford PhD developers, at companies with nearly unlimited
resources:

* amazon breaking the internet when a dev takes down EC2
* 

Consider how *hard* it can be to catch bugs:
* heartbleed
* spectre/meltdown - https://meltdownattack.com/, which has been around for
  *decades*

The point is: even the best-in-the business make catastrophic mistakes. It might take time,
but almost always happens. Again and again and again we see this.

It would only take one mistake like this to sink Bitcoin. And Bitcoin lacks all
of the advantages enjoyed by these companies.

### Could bitcoin go to zero?

Could an exploited bug actually destroy the value of Bitcoin? What would it take
for a bug to bring the price to $0, or close to it?

Caveat: this question is complicated by the murkiness of Bitcoin's identity
conditions. I could imagine a scenario in which there was a successful exploit,
with multiple competing solutions, multiple competing chains, and people
disagreeing about which one is "really" bitcoin. Let's just ignore this problem.
(Is it complicated? Can't we just say: "I don't care about your word 'bitcoin',
I just care about the value. Whether there's a new chain, two new chains, or
100, I don't care so long as I come out with value if I went in with it.)

I think many people think a bug could potentialy take bitcoin to zero. But what
would a truly disastrous bug look like? Here are some examples off the cuff:

* someone figures out how to lock people's coins, or spend people's coins
  without having their keys
* someone mints a billion new BTC and sends them all over the network
* someone breaks SHA256

But then there's always the rebuttal that these attacks could be (relatively)
easily reversed by a community-accepted hardfork, in the way that the ETH
community accepted a hardfork rolled back the DAO attack back in 2016. Attacks
like those above would obviously
dent the value of Bitcoin, but it seems the potential to reverse them would largely
mitigate the damage.

So are there any bugs that couldn't be rescued by a hardfork strategy?

* a bug that discretely minted lots of new BTC over a long period of time
* a bug or weakness in ellyptical curve cryptography which would allow someone
  to derive a private key from a public key
* a bug that simultaneously effected all known hashing algorithms

