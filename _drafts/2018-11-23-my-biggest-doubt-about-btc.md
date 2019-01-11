---
title: "My Biggest Doubt About Bitcoin"
date: "2018-11-22"
excerpt: My thoughts on the inherent risks of bitcoin.
---

_DISCLAIMER: At the time of writing, I own bitcoin. I am not a financial advisor
and this is not financial advice. Do your own research and consult with a
qualified professional before investing._

### TLDR

I think the following scenario is plausible and could massively devalue the
Bitcoin network:

1. Bitcoin grows drastically in visibility and popularity. It becomes very easy
   for ordinary people to acquire and control. It becomes less novel, scary,
   strange. It becomes the newest ordinary asset, like stocks or bonds or gold
   or cash.
2. Because of (1), people begin to convert important amounts of money into
   Bitcoin -- down-payments, retirements, college savings, life savings,
   inheritances, etc.
   Moreover, they do so uncritically, without considering the risks.
3. Bitcoin is successfully attacked. A significant minority of people
   irretrievably lose these important amounts of money. Too few people are
   attacked for the network to agree to a hard-fork to reverse the damage.
4. When news spreads of (3), there is a kind of Bitcoin "bank run". The people
   who uncritically bought into Bitcoin
   realize for the first time that their futures can be stolen from them
   without recourse, and they rush en-masse to exchange their Bitcoin for fiat.
5. The value of Bitcoin and all other decentralized cryptocurrencies plummets.
   The bank-run ensures the very thing people wanted to avoid: their money is
   gone. Bitcoin becomes nearly valueless.

I'll argue for the plausibility of each of these events in the sections
below.

### 1. Bitcoin Will Become Ordinary

I'm not going to argue why I think Bitcoin will grow massively in visibility and
popularity, eventually becoming an ordinary asset like cash, stocks, bonds, and
gold. I won't do it, in part, because this is honestly just conjecture. No one
(me included) really _knows_ whether or not this is true, and I won't try to
trick you into thinking otherwise.

Fortunately, I don't think my overall argument requires me to argue for this
claim. I think I can simply _assume_ it, because to do otherwise would be to
effectively [beg the question](https://en.wikipedia.org/wiki/Begging_the_question) against
my conclusion -- to essentially assume what I'm trying to prove: that the future
doesn't look good for Bitcoin.

I say this because if Bitcoin never rises massively in visibility and
popularity, if it just remains a marginal, niche asset that most people don't
want to own or use, then it will become nearly useless, which is to say nearly
valueless. I need not say that expectations about Bitcoin's future popularity
and usage are largely driving its current value. Take those expectations away,
and Bitcoin is revealed as a currency that almost no business will accept, that
almost no ordinary person will use, that is extremely expensive to power, and
that enjoys none of the consumer protections of other asset-classes. In other
words: if the future doesn't hold massive adoption and visibility for Bitcoin,
the future doesn't look good for Bitcoin. That's exactly what I'm trying to
argue.

So, let's assume the best-case scenario for Bitcoin's future and then go on to
show that _even then_ the network has an important vulnerability.


### 3. Bitcoin Will Be Successfully Attacked

I've argued at length in a previous post why I think [it is almost certain that
Bitcoin will be successfully attacked](link) at some point in the future. It is
only a matter of time. Briefly, the argument was:

* the Bitcoin core software has to continue changing indefinitely
* each change adds a non-zero chance of catastrophic failure
* after enough changes, the probability of an exploitable bug
  approaches 100%; it is now ~99.5% even under conservative assumptions

I'm just going to assume that this is true going forward.

Who cares?

Why should anyone care about an exploitable bug in Bitcoin? After all,
we all saw what happened when [the DAO was hacked in mid
2016](https://blog.ethereum.org/2016/06/17/critical-update-re-dao-vulnerability/): the Ethereum
community just [hard-forked to restore the stolen
funds](https://pastebin.com/xW16N7Ye). Wouldn't the Bitcoin
community just do the same thing? [Arjun
Balaji](https://unconfirmed.libsyn.com/arjun-balaji-on-the-ways-bitcoin-will-improve-in-2019-ep054), for example, finds this line of reasoning pretty compelling.

It's a good question. Maybe the Bitcoin community would rise to the challenge
and accept a hard-fork to reverse a bug exploit. Then again, the level of
disagreement and partisanship within the Bitcoin community suggests that this
is a non-trivial assumption. Mike Hearn's [medium
post](https://blog.plan99.net/the-resolution-of-the-bitcoin-experiment-dabb30201f7)
from early 2016 gives an insider's view of just how divided the community was
([and](https://en.wikipedia.org/wiki/Bitcoin_Cash)
[still](https://medium.com/@OneMorePeter/onwards-all-in-on-segwit-9e7cb3faa73d)
[is](https://bitcoinsv.io/) [today](https://www.bitcoinabc.org/)). And let's
not forget that that when Ethereum forked it was still in its infancy, still had
not reached mainstream attention, and had a network value [under $1 billion
dollars](https://coinmarketcap.com/historical/20160619/). Ethereum had much less
at stake.

But let's assume Arjun is right: major exploits to Bitcoin would be reversed.
Everyone would behave rationally and recognize that they shouldn't allow
attackers to get away with billions of dollars of other people's money. It would
devalue the entire network, including their little piece of it.

But what about minor exploits?

What if the attack that succeeds is fairly small, effecting just a small
fraction of Bitcoin's total value. Maybe just a hundred people, or a thousand. A
couple discreet exploits of the same bug, over the course of a few hundred
blocks. A few million dollars are stolen in total. A drop in the bucket. A
fraction of a fraction. It takes a while for people to even notice.

The Bitcoin community would have far less incentive to hard-fork to reverse a
small attack like the one I've described. Very few people would be helped by it.
Those who would be helped would have lost relatively very little. If the
attacker was smart, he/she could target people along party lines, so that only
one faction within the community has a stake in forking. Or they could attack
people who have no voice in the community at all, who would be hard-pressed to
drum up feelings for their plight. Or they could space out attacks over several
blocks so that many legitimate transactions would have to be reversed as well,
ensuring that forking would be painful for those who have not been stolen from.
Perhaps the attack could be timed to coincide with a number of big transactions,
so that reversal would be maximally painful, and the collateral damage very
large. And remember: hard-forks are inherently very risky. Risking a permanent split to
the network -- a potential halving of the network's value -- to save just a few
million dollars for a hand-full of people is a tough sell indeed.

Not only would the community be far less likely to agree on a hard-fork for a
small attack versus a big one, but a small attack is also much more likely than
a big one. Bitcoin has been battle-tested for over 10 years now. It's arguable
that the big issues have already been found and fixed. There are tests for them.
Developers have them in mind and look out for them when writing and reviewing
code.  A small bug, though -- that's the kind of thing you could create with
just a little sloppy programming. Suppose it's at the periphery of the system.
The PR is given only cursory review by one or two people before merging, the
whole process overshadowed by more ambitious PRs being reviewed at the same
time.

Nothing extraordinary is needed for someone to fat-finger a small bug into Core
and get it into a release.



### The stakes are high

Pampered as Americans are by the long-term stability of our government and its
[willingness to prop up its financial institutions in times of
crisis](https://en.wikipedia.org/wiki/Federal_takeover_of_Fannie_Mae_and_Freddie_Mac),
I think it's easy for us to forget what is at stake in a system like Bitcoin -- a
system without a backer. There is no crypto
[FDIC](https://en.wikipedia.org/wiki/Federal_Deposit_Insurance_Corporation) to
appeal to if/when you lose your coins to an exploited bug. There is no customer
service to freeze your account if/when an attack exposes your
private keys. If someone steals your coins, or destroys the network, or
enables new coins to be silently minted for years and drives prices almost to $0,
that's it: the value you placed in Bitcoin would be gone. There are no good guys
to get it back for you.

To most people who own Bitcoin, all of this is probably obvious. But most people
don't have a substantial part of their livelihood in Bitcoin. They don't really
rely on Bitcoin the way they do fiat currency for any of the important things in
life. So they haven't really had to come to terms with the risks. It's not
implausible to think that as Bitcoin gains in visibility and popularity, more
and more people will put more and more of their livelihoods into it. It will
become less novel, less scary. There will be less and less cause for
reflection on what the risks of a trustless money system really are, or on what
we're giving up by using one.

What we're seeing is an inherent difficulty of trying to make money out of
software.  Software _breaks_. We don't think of money as a breakable kind of
thing -- especially since most of us store the vast majority of our money in
banks. A dollar bill could be destroyed: burned, shredded, whatever. But when
your money is in a bank in good standing with the government, it seems to take
on a special kind of permanence. The bank could get hacked, or robbed, or go up
in flames, or declare bankruptcy. Your credit cards could get stolen, your
credentials could be leaked, etc.  None of it matters if the bank is FDIC
insured.  You would still have your money -- _obviously_ you would still have
your money: because money is indestructible -- right? -- your possession of it
as real and objective as the chair I am sitting in. Banks might keep a record of
it, but their record is merely the transient image of a deeper economic reality.

I don't think people often appreciate the importance of this picture of the
world, nor the extent to which it effects their lives and informs their
decisions (however implicitly/subconsciously). I, for example, don't _think
twice_ about depositing my money in the bank. In it goes, every cent. Nor do I
lose sleep about being able to withdraw it. I carry no cash. I have no stash under my
mattress. When I put money away for retirement, it all goes into
the bank. I keep no valuables like precious
metals, or fine wines, or works of art. I would not behave this way were this
economic picture not coloring virtually every economic reason and expectation I
have.

So the question we all need to ask is this.

When Bitcoin is inevitably exploited -- when those who put their trust in it
irrevocably lose their [life-savings](https://www.reddit.com/r/Bitcoin/comments/772kkf/trying_to_play_it_cool_with_my_life_savings_in/), their [retirements](https://www.reddit.com/r/Bitcoin/comments/7hraxb/401k_to_bitcoin/dqt6jb6/), their [homes](https://www.reddit.com/r/Bitcoin/comments/7kw2l7/just_took_out_a_mortgage_on_my_house_to_buy_btc/)
--  and when they (and we) are for the first time really forced to ask ourselves
just how important this economic picture of the world is, what will we
do? Will we double-down? Rally to the moon? Or will we all be talking about the great
bitcoin [bank run](https://en.wikipedia.org/wiki/Bank_run) of 2032?

I have no confidence that this is a picture many of us are really, truly
willing to forsake.
