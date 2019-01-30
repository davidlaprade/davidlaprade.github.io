---
title: "My Biggest Doubt About Bitcoin"
date: "2019-01-09"
tags: bitcoin crypto
excerpt: "A risk to the cryptocurrency that I don't think people are taking
seriously"
---

_DISCLAIMER: At the time of writing, I own bitcoin. I don't approve of or condone
attacks on the Bitcoin network. I am not a financial advisor
and this is not financial advice. Do your own research and consult with a
qualified professional before investing._


### TLDR

I think that the future doesn't look good for Bitcoin, one way or another. My
main concern centers around the plausibility of this scenario:

1. Bitcoin grows drastically in visibility and popularity. It becomes very easy
   for ordinary people to acquire and control. It becomes less novel, scary,
   strange. It becomes the newest ordinary asset, like stocks or bonds or gold
   or cash. [Assumed, for sake of argument]
2. Because of (1), people begin to convert important amounts of money into
   Bitcoin -- down-payments, retirements, college savings, life savings,
   inheritances, etc. Moreover, they do so uncritically, without considering the
   risks.
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
popularity. I won't do it in part because that would be dishonest. No one
(me included) really _knows_ whether or not this is true, and I won't try to
trick you into thinking otherwise.

I also won't do it because I don't need to. My overall argument doesn't require
me to. I'll simply _assume_ that Bitcoin will grow massively -- because to do
otherwise would be to effectively [beg the
question](https://en.wikipedia.org/wiki/Begging_the_question) against my
conclusion -- to essentially assume what I'm trying to prove in proving it,
namely: that the future doesn't look good for Bitcoin.

Probably unnecessary:
    I say this because if Bitcoin never rises massively in visibility and
    popularity, if it just remains a marginal, niche asset that most people don't
    want to own or use, then it will become nearly useless, which is to say nearly
    valueless. I need not say that expectations about Bitcoin's future popularity
    and usage are largely driving its current value. Take those expectations away,
    and Bitcoin is revealed as a currency that almost no business will accept, that
    almost no ordinary person will use, that is extremely expensive to power, and
    that enjoys none of the consumer protections of other asset-classes. A currency
    without a network is worthless. In other
    words: if the future doesn't hold massive adoption and visibility for Bitcoin,
    the future doesn't look good for Bitcoin. That's exactly what I'm trying to
    argue.

I'm also going to assume that in the future when
Bitcoin is massively popular, most people will have direct control over their
bitcoins (i.e. they will have exclusive access to their own private keys).
Whether this is done via hardware wallets or by some other means,
I won't speculate. But the important point is that trusted institutions (like
banks, like [Coinbase](https://www.coinbase.com/)) _will not_ be the primary way most people store their coins.

Perhaps this sounds implausible. But this too, I think, is forced on me if I
want to avoid question-begging. If almost everyone needed trusted 3rd parties in
order to use Bitcoin, then the stated goal of the project -- to be a "purely
peer-to-peer version of electronic cash [that] would allow online payments to be
sent directly from one party to another without going through a financial
institution"<sup>0</sup> -- would be a manifest failure. This, too, would be a
dark future for Bitcoin: our best hope of financial freedom and empowerment
swallowed whole by the very system it was meant to overturn. Such a Bitcoin,
almost all of which's transactions would be created and signed by trusted
intermediates, would be effectively controlled by those intermediates. One could
imagine them putting in waiting periods (similar to what are in place to avoid
fraud for ACH transfers) before actually broadcasting a transaction to the
network. People's funds could be frozen or seized from them. It would turn out
to offer few improvements over the existing financial system.

So, let's assume the best-case scenario for Bitcoin's future. Let's assume that
Bitcoin lives up to expectations: it becomes the amazing thing so many people
are excited about. We'll go on to show that _even then_ the network has an
important vulnerability.

Things you need to assume:
1. Bitcoin achieves mass adoption
2. Adoption is not via trusted 3rd parties
3. There is no insurance, or most people don't have it
4. People put personally significant amounts of money into bitcoin
5. The bitcoin held by ordinary people constitutes a significant percentage of
   the 21 million total coins

### 2. Bitcoin Will Hold Personally Significant Amounts of Value

By a _personally significant_ amount of value, I mean an amount of value that
plays an important role
in a person's life. Examples would be a down payment, a college savings
fund, a retirement account, a wedding fund, an inheritance, an emergency fund,
etc.

In the dark future we're imagining -- in which Bitcoin has at last come to rule the
world -- I think it's exceedingly probable that there will be many people who
entrust personally significant amounts of money to it.

I say this for a few reasons.

First, because people are _already_ doing it. People are putting their
[life-savings](https://www.reddit.com/r/Bitcoin/comments/772kkf/trying_to_play_it_cool_with_my_life_savings_in/),
their
[retirements](https://www.reddit.com/r/Bitcoin/comments/7hraxb/401k_to_bitcoin/dqt6jb6/),
their
[homes](https://www.reddit.com/r/Bitcoin/comments/7kw2l7/just_took_out_a_mortgage_on_my_house_to_buy_btc/)
into Bitcoin. [Ben Shapiro was recently
pushing](https://twitter.com/oliver_drk/status/1081709607129698305)<sup>1</sup>
a company, [BitIRA](https://www.bitira.com/), that --
you guessed it -- will convert one's entire retirement savings into Bitcoin.

Yes, there will likely be a rise in cryptocurrency insurance. (HAVE to address
this point)

Remember that we're assuming that people, not the banks, control their private
keys. That means, very likely, that people's Bitcoin are almost certainly not
insured. Banks are relatively easy entities to insure. They have security
experts working for them. They can provide the insurance company with confidence
that there is a very low probability they will be successfully stolen from.
Not FDIC insured, for one. One could imagine a market for private
Bitcoin insurance. But it seems that that would be very expensive, because fraud
would be so rampant. Just imagine: you have a supply of Bitcoin, you take out
insurance on it, you then send your coins to a new address and tell the
insurance company that they have been stolen. How does the insurance company
know whether or not this is true? Moreover, such insurance would be elective:
people would need to seek it out.

### 3. Bitcoin Will Be Successfully Attacked

I've argued at length in a previous post why I think [it is almost certain that
Bitcoin will be successfully attacked](link) at some point in the future. It is
only a matter of time. Briefly, the argument was:

* the Bitcoin core software has to continue changing indefinitely
* each change adds a non-zero chance of catastrophic failure
* after enough changes, the probability of an exploitable bug
  approaches 100%; it is now ~99.5% even under conservative assumptions

I'm just going to assume that this is true going forward. Moreover, I'm going to
assume that the exploit occurs after Bitcoin has become massively popular and
the incentive to attack it is very strong.

Who cares?

Why should anyone care about an exploitable bug in Bitcoin? After all,
we all saw what happened when [the DAO was hacked in mid
2016](https://blog.ethereum.org/2016/06/17/critical-update-re-dao-vulnerability/): the Ethereum
community just [hard-forked to restore the stolen
funds](https://pastebin.com/xW16N7Ye). Wouldn't the Bitcoin
community just do the same thing? Some people, [Arjun
Balaji](https://unconfirmed.libsyn.com/arjun-balaji-on-the-ways-bitcoin-will-improve-in-2019-ep054) for example, find this line of reasoning pretty compelling.

It's a good question. Maybe the Bitcoin community would rise to the challenge
and accept a hard-fork to reverse a bug exploit. Then again, the level of
disagreement and partisanship within the Bitcoin community suggests that this
is a non-trivial assumption. Mike Hearn's [medium
post](https://blog.plan99.net/the-resolution-of-the-bitcoin-experiment-dabb30201f7)
from early 2016 gives an insider's view of just how divided the community was
([and](https://en.wikipedia.org/wiki/Bitcoin_Cash)
[still](https://medium.com/@OneMorePeter/onwards-all-in-on-segwit-9e7cb3faa73d)
[is](https://bitcoinsv.io/) [today](https://www.bitcoinabc.org/)). And let's
not forget that when Ethereum forked it was still in its infancy, still had
not reached mainstream attention, and had a network value [under $1 billion
dollars](https://coinmarketcap.com/historical/20160619/). Ethereum had much less
at stake.

But let's assume Arjun is right: major exploits to Bitcoin would be reversed.
Everyone would behave rationally and recognize that they shouldn't allow
attackers to get away with billions of dollars of other people's money. It would
devalue the entire network, including their little piece of it.

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
network -- a potential _halving_ of the network's value -- to save just a few
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

### 4. There Will Be a Bitcoin Bank Run

After an attack is recognized and the community refuses to reverse it via
hard-fork, one could imagine stories beginning to come out about the people
effected. (Imagine how eagerly the Wall Street Journal would run with a story
like this.) You'd hear about how person A lost his life savings, how B won't be
able to send her kids to college, how C's down-payment is gone and his kids are
sleeping 3 to a room, how D lost her retirement and will have to continue
working indefinitely. Etc.  The stories would be poignant. They'd trend, maybe
even go viral.  The point is: they'd resonate with most people, especially those
who had themselves put significant amounts of money into Bitcoin.

So, now, imagine you are one of those people. You didn't really know what you
were getting yourself into when you put your savings into Bitcoin. You just knew
that people said no one could steal it from you, that it'd be there when you
really needed it, that the crooks in the banks couldn't profit off like they
do the other money you give them. As for the risks, you figured it was like
anything else: you didn't know anything about stocks or bonds or any of that
other finance mumbo-jumbo either. But now, here you are, and you've just found
out that your Bitcoin -- your life savings -- is not safe. Not only that, but
there isn't even any insurance to give you your money back if it is stolen.

What do you do? This is your _life savings_, remember. I think, in just about
any other context, if you really believed your life savings was at risk, you'd
do whatever you could to eliminate that risk, and eliminate it fast. And here,
the most obvious way of doing that is to convert your Bitcoin
into something else, i.e. to sell it.

Now, this is all a bit of [armchair
psychology](https://psychologydictionary.org/armchair-psychology/), which I need
not say is an unreliable source of knowledge. Beyond that, it's armchair
psychology about counterfactuals -- about how people _would_ behave were things
different than they are. And counterfactual knowledge is among the most difficult kind to
acquire. So I can't really say that I *know* people would respond this way if
this happened.  Nevertheless, I still think it's plausible. Why?

We *do know* how people behaved in the past when they believed that
personally important amounts of money were at risk: they ran, _en masse_ to
withdraw them. These so-called
[bank runs](https://en.wikipedia.org/wiki/Bank_run) triggered
the Great Depression, and eventually led to the creation of the
[FDIC](https://en.wikipedia.org/wiki/Federal_Deposit_Insurance_Corporation),
which ensures that the federal government will give you your money back, even
if the bank doesn't.

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
forever. Given the history, I think the burden of proof is on someone who thinks
that people *wouldn't* try to move their money out of Bitcoin in circumstances
like this. The assumption should be that history will repeat itself unless there
is overriding evidence otherwise.

Hence, I say that a mass Bitcoin sell-off is a live possibility in the event of
a successful attack like the one I have described.

### 5. The Value of Bitcoin Will Plummet

It's simple supply and demand.

-----------

0. https://bitcoin.org/bitcoin.pdf

1. In case the Tweet I've linked to gets removed, the clip it links to is from
_The Ben Shapiro Show_, Ep. 512. April 6th, 2018.

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
