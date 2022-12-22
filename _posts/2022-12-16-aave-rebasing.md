---
title: "How ScopeLift Built a Flex Voting aToken on Aave"
tags: crypto
excerpt: "What the title says"
---

[Aave](https://aave.com/) is a popular DeFi protocol that allows users to trustlessly earn interest, borrow assets, take out flash loans, etc.

ScopeLift was [recently
awarded](https://twitter.com/AaveGrants/status/1586858440080572417) a grant by the Aave Grants DAO to add [flexible voting](https://www.scopelift.co/blog/introducing-flexible-voting) to that list.

In this post, we're going to explain how Aave calculates interest on deposits,
and how their approach made it possible for us to implement a flex voting
aToken **[TODO link to our contract in github]**.

### aToken Rebasing ELI5

When users deposit tokens into Aave, they receive [ERC20](https://ethereum.org/en/developers/docs/standards/tokens/erc-20/) tokens in return.
Aave's ERC20's are called [aTokens](https://github.com/aave/aave-v3-core/blob/f3e037b3638e3b7c98f0c09c56c5efde54f7c5d2/contracts/protocol/tokenization/AToken.sol).
If you deposited [DAI](https://polygonscan.com/address/0x8f3cf7ad23cd3cadbd9735aff958023239c6a063) on Polygon, you would receive [aPolDAI](https://polygonscan.com/address/0x82E64f49Ed5EC1bC6e43DAD4FC8Af9bb3A2312EE) back.
[Here](https://docs.aave.com/developers/deployed-contracts/v3-mainnet/polygon#tokens) is a list of other commonly-issued aTokens.

aTokens are _receipt tokens_: they represent a claim on deposited assets.
When you want to [withdraw](https://github.com/aave/aave-v3-core/blob/f3e037b3638e3b7c98f0c09c56c5efde54f7c5d2/contracts/protocol/pool/Pool.sol#L197-L217) your deposit and claim its accumulated interest, your aTokens are [burned](https://github.com/aave/aave-v3-core/blob/f3e037b3638e3b7c98f0c09c56c5efde54f7c5d2/contracts/protocol/libraries/logic/SupplyLogic.sol#L131-L136).

One thing that makes Aave's aTokens interesting is that their balance programmatically increases over time.
If you have (say) 100
[aPolWETH](https://polygonscan.com/address/0xe50fA9b3c56FfB159cB0FCA61F5c9D750e8128c8) today, at an interest rate of 2% APY, you will have 102 aPolWETH in a year from now.
That's without making any new deposits or interacting with the protocol or anything.
It's [built
into](https://github.com/aave/aave-v3-core/blob/f3e037b3638e3b7c98f0c09c56c5efde54f7c5d2/contracts/protocol/tokenization/AToken.sol#L131-L139) the aToken contract.

This is called _rebasing_.
Said another way, aTokens are _rebase tokens_.

Aave has a really interesting implementation of rebasing -- one which we believe is not well understood.
One of the things we want to do in this post is explain how it works.

#### Liquidity Indexes

A key concept in understanding aToken rebasing is the notion of a __liquidity index__.
It's defined in their [v2
whitepaper](https://raw.githubusercontent.com/aave/protocol-v2/master/aave-v2-whitepaper.pdf) as follows:

> Interest cumulated by the reserve during the time interval ∆T, updated
> whenever a borrow, deposit, repay,
> redeem, swap, liquidation event occurs.

In other words, __the liquidity index for a certain asset is the total amount of interest earned by
deposits of that asset into Aave__ -- expressed as a percentage scaled up by a
[ray](https://github.com/aave/aave-v3-core/blob/f3e037b3638e3b7c98f0c09c56c5efde54f7c5d2/contracts/protocol/libraries/math/WadRayMath.sol#L17).

Let's unpack that for a second, because it's a mouthful and this is really important.

aPolyDAI currently has a liquidity index of `1010832786421347125844242759`, or
1.083%. This means that _in aggregate_, over the entire lifetime of Aave, DAI deposits have earned 1.083%.
So if you were the very first person to deposit DAI into
Aave and you haven't touched it since, your deposit would today be worth 1.083% more.

Each asset has an independent liquidity index associated with it.
And indexes are constantly increasing.
As noted in the whitepaper, an index increases any time a fee-generating action
is taken by a user.

Take borrowing, for instance.
Suppose you've supplied DAI to Aave and someone else borrows DAI.
The borrower will pay a certain amount of interest into Aave for the privilege, and that interest will accrue to you and other suppliers of DAI.

_How_ it does so is by increasing the DAI liquidity index.
It happens
[here](https://github.com/aave/aave-v3-core/blob/f3e037b3638e3b7c98f0c09c56c5efde54f7c5d2/contracts/protocol/libraries/logic/ReserveLogic.sol#L291-L297) in the code:

{% highlight js %}
// Calculate the amount of interest that accrued since the last update.
// The amount will be a ray-based percentage.
uint256 cumulatedLiquidityInterest = MathUtils.calculateLinearInterest(
  reserveCache.currLiquidityRate,
  reserveCache.reserveLastUpdateTimestamp
);

// Add that interest to the current index by multiplying them together.
reserveCache.nextLiquidityIndex = cumulatedLiquidityInterest.rayMul(
  reserveCache.currLiquidityIndex
);
{% endhighlight %}

For example, if the current liquidity index is `1050000000000000000000000000`
(i.e. 5%) and another 2.5% has accrued since the last update, the new index will
be `1076250000000000000000000000` (because 1.05 * 1.025 = 1.07625).

It might not be obvious, but an increase in the liquidity index _just is_ the accrual of interest within Aave.
The former constitutes the latter.
This is because any increase to the liquidity index results in a corresponding increase in aToken balance, as we'll see in the next section.

#### Scaled Balances

The second key thing to understand about Aave is that **it scales user balances down by the liquidity index before writing them to storage**.

When you deposit (say) $100 DAI into Aave, your balance is not incremented by
100e18 in storage. Rather, your balance is incremented by your deposit [_divided
by_](https://github.com/aave/aave-v3-core/blob/f3e037b3638e3b7c98f0c09c56c5efde54f7c5d2/contracts/protocol/tokenization/base/ScaledBalanceTokenBase.sol#L75) the [current liquidity index](https://github.com/aave/aave-v3-core/blob/f3e037b3638e3b7c98f0c09c56c5efde54f7c5d2/contracts/protocol/libraries/logic/SupplyLogic.sol#L73). So if the current aPolyDAI liquidity index is
1.083%, then your balance would be incremented by 100e18/1.01083, or ~98.93e18.
This scaling down of balances can also
be seen in the aToken's [burn](https://github.com/aave/aave-v3-core/blob/f3e037b3638e3b7c98f0c09c56c5efde54f7c5d2/contracts/protocol/tokenization/base/ScaledBalanceTokenBase.sol#L108) and [transfer](https://github.com/aave/aave-v3-core/blob/f3e037b3638e3b7c98f0c09c56c5efde54f7c5d2/contracts/protocol/tokenization/AToken.sol#L219) functions.

Does this mean that all deposits immediately lose value -- in this case 1.083%?

No.

Because on the way out Aave scales balances _up_ by the current index. This
happens in two places in the aToken:
[totalSupply](https://github.com/aave/aave-v3-core/blob/f3e037b3638e3b7c98f0c09c56c5efde54f7c5d2/contracts/protocol/tokenization/AToken.sol#L149)
and
[balanceOf](https://github.com/aave/aave-v3-core/blob/f3e037b3638e3b7c98f0c09c56c5efde54f7c5d2/contracts/protocol/tokenization/AToken.sol#L131-L139).
For now, let's focus on the latter.
It looks like
[this](https://github.com/aave/aave-v3-core/blob/f3e037b3638e3b7c98f0c09c56c5efde54f7c5d2/contracts/protocol/tokenization/AToken.sol#L131-L139) (indented to make it easier to read):

{% highlight javascript %}
super.balanceOf(user).rayMul(
  POOL.getReserveNormalizedIncome(_underlyingAsset)
);
{% endhighlight %}

`rayMul` just means [multiply these values together then
divide by a
ray](https://github.com/aave/aave-v3-core/blob/f3e037b3638e3b7c98f0c09c56c5efde54f7c5d2/contracts/protocol/libraries/math/WadRayMath.sol#L65-L74).

So this `balanceOf` function is simply multiplying two values
together. The first should be obvious: [it's just the user's balance in
storage](https://github.com/aave/aave-v3-core/blob/f3e037b3638e3b7c98f0c09c56c5efde54f7c5d2/contracts/protocol/tokenization/base/IncentivizedERC20.sol#L106-L108).

The second is less obvious. The logic for the getReserveNormalizedIncome function [looks like
this](https://github.com/aave/aave-v3-core/blob/f3e037b3638e3b7c98f0c09c56c5efde54f7c5d2/contracts/protocol/libraries/logic/ReserveLogic.sol#L40-L64) (again, with indentation):

{% highlight javascript %}
MathUtils.calculateLinearInterest(
  reserve.currentLiquidityRate,
  reserve.lastUpdateTimestamp
).rayMul(
  reserve.liquidityIndex
);
{% endhighlight %}

So, the aToken `balanceOf` function is simply multiplying the stored
balance by the current liquidity index (incremented by whatever interest has not
yet been factored in).

Initially, this cancels out the effect of scaling down the balance, so that if
someone went to withdraw immediately after depositing they would get all of
their money back. E.g. a stored balance of
98.93e18 aPolyDAI would be multiplied by the liquidity index of 1.01083, resulting a
withdrawable balance of 100 DAI.

But over time, as the liquidity index increases, it results in a net positive aToken balance, since the stored balance is being multiplied by a larger number than the deposit was initially divided by.

#### A Toy Example

Let's put these concepts together and see how interest works in a bigger
context.

* suppose some asset has earned 5% interest over its lifetime in Aave
* the liquidity index for this asset will be 5%, or 1.05e27
* Ben deposits $100 of the asset
* the aToken scales down his deposit by the liquidity index and stores the result,
  in this case 100 / 1.05 == 95.23
* if Ben immediately withdrew his money, his rebased balance would be: `storedBalance * liquidityIndex`, i.e. 95.23 * 1.05 == $100, what we expect
* a year goes by and the pool earns another 5% interest, so the new liquidity index is 1.05 * 1.05 == 1.1025
* I now deposit $100 of the asset
* once again, the aToken scales down my deposit and stores the result: 100 / 1.1025 == 90.70 is my balance in storage
* if I immediately withdrew, my rebased balance would be 90.70 * 1.1025 == $100, i.e. exactly what I put in
* Ben's rebased balance at this point would be 95.23 * 1.1025 == $105
* so he'd have 5% more underlying than me, as expected (since the pool as a whole earned 5% while he had his money in it)

And that's it! That is how interest works in Aave.

### Flexible Voting

[Flexible voting](https://www.scopelift.co/blog/introducing-flexible-voting) (or _flex voting_ for short)
is a novel extension to Compound-style governance systems.
It allows delegates to split their voting weight across For/Against/Abstain options, rather than having to put all of it behind one.

If flex voting could be added to aTokens, this would unlock a large amount of
value for Aave.

To see why, imagine you hold UNI.
UNI gets its intrinsic value from being the voting token for [Uniswap governance proposals](https://app.uniswap.org/#/vote).
Anyone who holds UNI can delegate and vote on these proposals and help set the course of one of the biggest projects in crypto.

So the main value of UNI comes from its use in voting.
But it would be really nice if you could also deposit your UNI to earn yield at the same time.

The trouble is that if you were to deposit UNI into a DeFi protocol (like Aave) you would lose your voting power.
This is because the address that holds the tokens controls their voting weight.
And if you deposit your UNI, the receiving contract -- not you -- would hold the tokens.

So governance token holders are forced to choose: either participate in governance or earn yield.
They cannot currently have both.

If flex voting were added to aTokens and the Aave DAO, however, they could.

In such a world, aToken holders would express their desired voting preference to
the aToken contract, which would then cast its vote in the appropriate ratios to
the governance contract.

So, for example, if 35% of aUNI holders expressed a "No" voting preference on a
given proposal, 60% expressed "Yes", and 5% "Abstain", then the aToken contract
would cast its vote to the UNI governance system with 35% of its weight as
Against, 60% of its weight as For, and 5% as Abstain.

aUNI holders would effectively get to vote without having a UNI balance!

While flex voting makes this dream scenario possible, it's not without
technical hurdles.
The next section will get into what these are and how we solved them.

### Implementing a Flex Voting aToken

If something like the dream scenario were to exist, it would have to take
account of the fact that aToken balances are constantly increasing, and doing so
at an ever-changing rate.

After all, if I could have burned my aTokens and withdrawn a certain weight of
voting tokens at the time of a proposal, any vote cast on my behalf by the aToken
should reflect that weight.

Let's look at a concrete example:

* Ben deposits 100 UNI into Aave
* a year passes and aUNI yields 50% interest (it was a _very_ good year)
* I deposit 100 UNI
* Ben and I are the only UNI depositors
* a UNI governance proposal is issued
* both Ben and I express our votes on the proposal to the aUNI contract
* Ben expresses a "For" preference
* I express an "Against" preference

When aUNI casts its vote to the UNI governance system, what should the vote ratios
be?

If you were only looking at our deposits you might think we
should have equal voting weight -- since we both deposited 100 UNI.
But that's wrong.
Ben should have _more_ voting weight than me because of all of the interest he
earned over the last year.

Ben's balance at the time of proposal was 150 aUNI.
This would have entitled him to have withdrawn (and voted with) 150 UNI at that time.
I, by contrast, could have only withdrawn and voted with the 100 UNI I had just deposited.

So, it seems what we need to look at are _rebased balances_, not deposits.
The rebased balances would have led us to the correct conclusion: Ben's voting preference should have 50% more voting weight than mine.
If the aUNI contract holds 250 UNI and Ben is entitled to 150 of that, Ben
should be able to determine 60% (150/250) of the votes aUNI casts, and I the
remaining 40% (100/250).

Thus it seems the dream scenario requires us to be able to
calculate the rebased aToken balance for _any given user_ at _any given block_.

In case it isn't obvious, this is very challenging.

As already mentioned, aToken interest rates are constantly changing
based on supply and demand within the protocol.
If supply goes up, interest goes down.
If demand goes up, interest goes up.

And each time the interest rate changes, the interest accrued since the last update
is added to the liquidity index (as shown above).
This means that the aToken liquidity index is constantly changing too.

Recall that the aToken's rebased balance is just the balance on disk multiplied by the liquidity index.

If both values (balance-on-disk and liquidity index) are constantly changing,
how can we hope to reliably compute a value based on them?

Short of checkpointing both values _each time they change_ -- which would be
unfeasibly expensive to write and later search for a popular asset with a lot of
usage on Aave -- there seems to be no simple way to accurately compute an
arbitrary user's aToken rebased balance at a block in the past.

Fortunately, we don't have to.

Instead, if we simply checkpoint each user's _scaled down balance_
(i.e. their balance in storage) we can get all of the information we need to precisely
calculate voting proportions.

This is because the rebased balance is `scaled-down-balance x liquidity index`.
Since every aToken holder's balance is being scaled up by the same liquidity
index, the liquidity index can be ignored when computing ratios.
For example, if the rebased balance for userA is `A x I` and the rebased balance for user B is
`B x I` then the ratio of userA's balance to userB's is just `A / B` -- the index
`I` cancels out.

But if we only compare the stored values, wouldn't Ben and I end up with
the same voting weight since we deposited the same amount?

No.

This is because Aave divides incoming balances by the current liquidity index before
storing them.

We can see how this works if we reframe the example above with stored balances:

* suppose UNI has earned in total 5% over its lifetime on Aave, i.e. index =
  1.05e27
* Ben deposits 100 UNI into Aave
* Ben's balance is stored as ~95.24 (100/1.05)
* a year passes and aUNI yields 50% interest (it was a _very_ good year)
* the new liquidity index is 1.575 (1.05 * 1.5)
* I deposit 100 UNI
* my stored balance is ~63.49 (100 / 1.575)
* if Ben withdrew now, he could claim 150 UNI (95.24 * 1.575), which is expected
  because he earned 50% APY this past year
* if I withdrew now, I could claim 100 UNI (63.49 * 1.575), which is expected
  because I just deposited
* a governance proposal is issued for UNI
* both Ben and I express our votes on the proposal to the aUNI contract
* Ben expresses a "For" preference
* I express an "Against" preference
* the aUNI contract can use our stored balances at the proposal block to
  determine our relative voting weights: Ben has 50% more voting weight than me
  (95.24 stored balance vs 63.49)

Aave's clever interest implementation neatly accommodates the exact information
needed to support flex voting aTokens.

### Conclusion

We hope that this has been a useful introduction to Aave's interest rate
implementation. You can view ScopeLift's flex voting aToken extension [here](/#).


