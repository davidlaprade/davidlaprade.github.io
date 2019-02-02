---
title: "My Biggest Doubt About Bitcoin"
date: "2019-02-01"
tags: bitcoin crypto
excerpt: "A risk to the cryptocurrency that I don't think people are taking
seriously"
---

_DISCLAIMER: At the time of writing, I own bitcoin. I like the project and want
to see it succeed. I don't approve of or condone attacks on the Bitcoin network.
I am not a financial advisor and this is not financial advice. Do your own
research and consult with a qualified professional before investing._

### TLDR

I'm concerned about the future of Bitcoin. It worries me that this might be true:

1. A large percentage of Bitcoin is uninsured and held by people who have
   significant amounts of money in it.
2. Bitcoin will be successfully attacked. A significant minority of people
   will irretrievably lose important amounts of money. Too little will be lost
   for the network to agree to a hard-fork to reverse the damage.
3. When news of (2) spreads, there will be a kind of Bitcoin "bank run". People
   will realize that personally significant mounts of money can be lost
   without recourse, and they will rush en-masse to exchange their Bitcoin for fiat.
4. The value of Bitcoin will plummet. The bank-run, coupled with a liquidity
   crunch will make Bitcoin untradeable for fiat on exchanges, rendering it
   effectively worthless.

This argument is gappy, I fully admit that. But I think each of its premises
is plausible enough, and its connections tight enough, that it succeeds in
justifying some degree of worry. I'll argue for each of its premises below.

### 1. Most Bitcoin is Uninsured and Held in Significant Quantities

It probably goes without saying that most Bitcoin is uninsured.
Bitcoin wallets are not
[FDIC protected](https://en.wikipedia.org/wiki/Federal_Deposit_Insurance_Corporation),
and private coverage is either non-existent or hard to come by.<sup>1</sup>

It's probably
equally obvious that the vast majority of coins is controlled by entities
(people/companies/governments) that own _a lot_ of them. At the time of writing,
[87% of coins are held
by just 0.65% of
addresses](https://bitinfocharts.com/top-100-richest-bitcoin-addresses.html),
and [62% of coins are held by addresses that contain 100 or more
coins](https://bitinfocharts.com/top-100-richest-bitcoin-addresses.html).
Obviously, many of these addresses are controlled by the same entities. Which is
to say that these entities own enough coins that it would probably cause them
great distress to think they were at risk of losing them.<sup>2</sup>

If either of these claims seems controversial, or doubtful, check out my
footnotes for more details. I think most people would agree with them, though,
so I won't say more here.

### 2. Bitcoin Will Be Successfully Attacked

I've argued at length in a previous post why I think [it is almost certain that
Bitcoin will be successfully attacked](/bitcoin-will-be-successfully-attacked)
at some point in the future. It is only a matter of time. Briefly, the argument
was:

* the Bitcoin core software has to continue changing indefinitely
* each change adds a non-zero chance of introducing an exploitable bug
* after enough changes, the probability of an exploitable bug
  approaches 100%; it is now ~99.5% even under conservative assumptions

So, I'm just going to assume that at some point Bitcoin will be successfully
attacked.

Who cares?

Why should anyone care about a successful Bitcoin exploit? After all,
we all saw what happened when [the DAO was hacked in mid
2016](https://blog.ethereum.org/2016/06/17/critical-update-re-dao-vulnerability/): the Ethereum
community just [hard-forked to restore the stolen
funds](https://pastebin.com/xW16N7Ye). Wouldn't the Bitcoin
community just do the same thing? Some people, [Arjun
Balaji](https://unconfirmed.libsyn.com/arjun-balaji-on-the-ways-bitcoin-will-improve-in-2019-ep054) for example, find this line of reasoning pretty compelling, and so
are unconcerned about bugs. As he says:

> If there is a bug in Bitcoin which causes undue inflation I think that we
> would patch the
> bug [and] fork to a different version of Bitcoin because that would be the new
> consensus. I think if there was a massively inflated Bitcoin
> almost no one who holds Bitcoin would want to participate in it. So I worry less
> about bugs like that.  [[Quote begins at
> 2:30]](https://unconfirmed.libsyn.com/arjun-balaji-on-the-ways-bitcoin-will-improve-in-2019-ep054).

It's a good question whether a fork could save the network in the event of an
exploited bug. Maybe the Bitcoin community would rise to the challenge
and accept a hard-fork to reverse a bug exploit. Then again, the level of
disagreement and partisanship within the Bitcoin community suggests that this
is a non-trivial assumption. Mike Hearn's [medium
post](https://blog.plan99.net/the-resolution-of-the-bitcoin-experiment-dabb30201f7)
from early 2016 gives an insider's view of just how divided the community was
([and](https://en.wikipedia.org/wiki/Bitcoin_Cash)
[still](https://medium.com/@OneMorePeter/onwards-all-in-on-segwit-9e7cb3faa73d)
[is](https://bitcoinsv.io/) [today](https://www.bitcoinabc.org/)). As Hearn put
it:

> [D]espite knowing that Bitcoin could fail all along, the now inescapable
> conclusion that it has failed still saddens me greatly.
> Why has Bitcoin failed? It has failed because the community has failed.
> [[Ref]](https://blog.plan99.net/the-resolution-of-the-bitcoin-experiment-dabb30201f7).

And let's
not forget that when Ethereum forked it was still in its infancy, still had
not reached mainstream attention, and had a network value [under $1 billion
dollars](https://coinmarketcap.com/historical/20160619/). Ethereum had much less
at stake than [Bitcoin does now](https://coinmarketcap.com/currencies/bitcoin/).

But let's assume Arjun is right: major exploits to Bitcoin would be reversed.
Everyone would behave selflessly and recognize that they shouldn't allow
attackers to get away with other people's money.

But what about minor exploits?

What if the attack that succeeds is fairly small, effecting just a small
fraction of Bitcoin's total value? Maybe just a hundred people, or a thousand. A
couple discreet exploits of the same bug, over the course of a few hundred
blocks. A few million dollars are stolen in total. A drop in the bucket. A
fraction of a fraction. It takes a while for people to even notice.

The Bitcoin community would have far less incentive to hard-fork to reverse a
small attack like the one I've described. Very few people would be helped by it.
Those who would be helped would have lost relatively little. If the attacker was
smart, he/she could target people along party lines, so that only one faction
within the community has a stake in forking. Or they could attack people who
have no voice in the community at all, who would be hard-pressed to drum up
feelings for their plight. Or they could space out attacks over several blocks
so that many legitimate transactions would have to be reversed as well, ensuring
that forking would be painful for those who have not been stolen from.  Perhaps
the attack could be timed to coincide with a number of big transactions, so that
reversal would be maximally painful, and the collateral damage very large. And
remember: hard-forks are inherently very risky. Risking a permanent split to the
network -- a potential _halving_ of the network's value and hash power -- to
save just a few million dollars for a hand-full of people is a tough sell
indeed.

Not only would the community be far less likely to agree on a hard-fork for a
small attack versus a big one, but a small attack is also much more likely than
a big one. Bitcoin has been battle-tested for over 10 years now. It's arguable
that the big issues have already been found and fixed. There are tests for them.
Developers have them in mind and look out for them when writing and reviewing
code.  A small bug, though -- that's the kind of thing you could create with
just a little sloppy programming. Suppose it's at the periphery of the system.
The PR is given [only cursory
review](https://github.com/bitcoin/bitcoin/pull/9049#issuecomment-257768800)
by one or two people before merging, the
whole process overshadowed by more ambitious PRs being reviewed at the same
time.

Nothing extraordinary is needed for someone to [fat-finger a small bug into Core
and get it into a release](https://github.com/bitcoin/bitcoin/pull/9049).

### 3. There Will Be a Bitcoin Bank Run

After an attack is recognized and the community refuses to reverse it via
hard-fork, one could imagine stories beginning to come out about the people
effected. (Imagine how eagerly the Wall Street Journal would run with a story
like this.) You'd hear about how person A lost his life savings, how B won't be
able to send her kids to college, how C's down-payment is gone and his kids are
sleeping 3 to a room, how D lost her retirement and will have to continue
working indefinitely. Etc. The stories would be poignant. They'd trend, maybe
even go viral. The point is: they'd get mainstream attention (because Bitcoin
is in the public eye), and they'd resonate with most people in the
cryptocurrency community, especially those who have significant amounts of money
in Bitcoin.

We know how people behaved in the past when they believed that
personally important amounts of money were at risk: they ran, _en masse_ to
withdraw them. These so-called
[bank runs](https://en.wikipedia.org/wiki/Bank_run) triggered
the Great Depression, and eventually led to the creation of the
[FDIC](https://en.wikipedia.org/wiki/Federal_Deposit_Insurance_Corporation).

Bank runs are surprisingly common. And when they happen, they tend to be
devastating:

> In the 16th century onwards, English goldsmiths issuing promissory notes
> suffered severe failures due to bad harvests, plummeting parts of the country
> into famine and unrest. Other examples are the Dutch Tulip manias (1634–1637),
> the British South Sea Bubble (1717–1719), the French Mississippi Company
> (1717–1720), the post-Napoleonic depression (1815–1830) and the Great
> Depression (1929–1939). [[Source]](https://en.wikipedia.org/wiki/Bank_run)

The kind of scenario we're considering has all the markers of a bank run: (i) a
large number of people (ii) realize at roughly the same time that (iii) there is
a real possibility that (iv) a significant amount of their money will be lost
forever unless (v) they act fast. Given the history, I think the burden of proof
is on someone who thinks that people *wouldn't* try to move their money out of
Bitcoin in circumstances like this. The assumption should be that history will
repeat itself unless there is overriding evidence otherwise.

Hence, I say that a mass Bitcoin sell-off is a live possibility in the event of
a successful attack like the one I have described.<sup>3</sup>

### 4. The Value of Bitcoin Will Plummet

Price is a function of (among other things) [supply and
demand](https://en.wikipedia.org/wiki/Supply_and_demand). It is directly
correlated with demand, and inversely
correlated with supply. If demand increases, price tends to rise (all else being
equal). If supply increases, price tends to fall (all else being equal). This
is Economics 101.

In a bank-run situation, there would be a massive surge in circulating Bitcoin
(increased supply) coupled with a concurrent drop in demand. This would constitute a
double blow to price.

What's less obvious is that there is a liquidity problem in cryptocurrency
exchanges -- where people would overwhelmingly go to sell their Bitcoin.
Here's a quote from Preston Byrne's [excellent
article](https://prestonbyrne.com/2017/11/26/the-bear-case-for-crypto-part-ii-fractional-reserve-marmot/) (which also
considers the possibility of a crypto bank run, albeit for different reasons):

> Holders expect that Bitcoin intermediaries/exchangers (exchanges, wallets,
traders) will be in a position to provide them with instant dollar liquidity
when they wish to margin trade or take their profits (dollar liquidity which, I
am reliably informed, is provided in part by mainstream commercial banks on a
very short-term basis at very high rates). [. . .]
[I]s it realistic to expect that exchanges, trading counterparties, and other
market participants are prudently hiving away their profits to stave off a
liquidity crunch?

The question is rhetorical, of course. The odds that the collective liquid
(fiat) assets and credit lines of the world's cryptocurrency exchanges currently
total the market capitalization of Bitcoin, some $60 billion dollars, seem
exceedingly low. Almost certainly they are a small fraction of that number.

A bank run, then, would likely exhaust the available liquidity in these systems
very quickly, meaning that -- no matter _what_ the quoted spot price of Bitcoin
had fallen to in the immediate wake of the run -- there would be effectively no
money to exchange for it, which is to say effectively no _demand_ for it. With
little or no demand for it, it would be valueless.

### Conclusion

A coin that miners cannot redeem for fiat -- to pay their electricity bills, to
pay their staff -- is a coin that miners won't mine, or won't mine for long.
And a network without miners is neither secure nor functional. In this way,
then, a bank run coupled with a liquidity crunch could not only drive down the
price but actually _kill_ the Bitcoin network permanently.

Whether this scenario will play out, or play out in exactly this way, is
anyone's best guess. I am simply worried that
others are not sufficiently concerned about it.

---------

1. Bitcoin wallets are not
[FDIC](https://en.wikipedia.org/wiki/Federal_Deposit_Insurance_Corporation)
insured. This means that, for most people's coins to be covered by insurance,
they'd need to have private insurance.  But private Bitcoin insurance seems hard
to come by at this early stage. A [quick Google
search](https://www.google.com/search?q=bitcoin+insurance) turns up no obvious,
legitimate-seeming providers, which means that people would not only need to
_seek out_ insurance, but also would need to do some non-trivial research to get
it. As a niche financial product, it likely would also be expensive. Moreover,
the libertarian-, privacy-, be-your-own-bank minded folks that have thus far
been attracted to Bitcoin are not the sort to seek out trusted 3rd parties to
secure their coins, nor to disclose important details about their financial
situation (how they store their coins, how many they have, what addresses they
use, etc). And there are good reasons to believe that [large numbers of people
who own Bitcoin do not live in the
US](https://usethebitcoin.com/10-countries-with-the-most-bitcoin-hodlers/), and
do not even have access to all of the financial resources we do. All of these
factors mitigate against people having insurance for their Bitcoin. Companies
like [Coinbase](https://www.coinbase.com/legal/insurance) and
[Gemini](https://www.businesswire.com/news/home/20181003005283/en/) have
insurance for their hotwallets. But, obviously, most coins are not stored in
these wallets.

2. It seems plausible that the vast majority of coins are
personally significant to those that own them. By a _personally significant_
amount of money for a person, _P_, I mean an amount of value that would play an
important role in P's life. Examples would be a down payment, a college savings
fund, a retirement account, a wedding fund, an inheritance, an emergency fund,
etc. If your coins are greater than or equal in value to any of these, then you
have a personally significant amount of value in Bitcoin. Losing this amount of
money would probably _really matter_ to you.  I say that most coins are probably
personally significant for two reasons.  First, because of the statistics I
cited earlier: 62% of coins are held by addresses that contain 100+ Bitcoin.
Second, because people routinely, openly, proudly broadcast that they _actually
are_ putting personally significant amounts of money into Bitcoin.  People are
putting their
[life-savings](https://www.reddit.com/r/Bitcoin/comments/772kkf/trying_to_play_it_cool_with_my_life_savings_in/),
their
[retirements](https://www.reddit.com/r/Bitcoin/comments/7hraxb/401k_to_bitcoin/dqt6jb6/),
their
[homes](https://www.reddit.com/r/Bitcoin/comments/7kw2l7/just_took_out_a_mortgage_on_my_house_to_buy_btc/)
into it. A quick [Twitter
search](https://twitter.com/search?f=tweets&q=bitcoin%20401k) shows just how
common this kind of thinking is. There is accordingly a
[growing](https://www.bitira.com/) market for [financial
services](https://bitcoinira.com/) that convert retirement accounts into
Bitcoin.

3. It bears emphasizing that the bank run would probably include other
decentralized cryptocurrencies as well. This is not only because most of these
currencies are still purchased with Bitcoin -- i.e. because they must be
bought/sold for Bitcoin before they can be bought/sold for fiat currencies --
and the loss of a functioning Bitcoin network would effectively lock up their
value until a new intermediate currency came along.  That's one issue. But I also think
the other decentralized cryptocurrencies would be sucked into the bank run
because the exact same concerns I have about Bitcoin apply to them. They are
just as prone (if not more so) to attack, and they are uninsured. These are not
safe-harbors for one's personally significant sums of money. They thus would not
likely absorb the value exiting Bitcoin. Nor would they escape the psychological
flight to safety.
