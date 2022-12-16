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
These ERC20's are called [aTokens](https://github.com/aave/aave-v3-core/blob/f3e037b3638e3b7c98f0c09c56c5efde54f7c5d2/contracts/protocol/tokenization/AToken.sol).
If you deposited [DAI](https://polygonscan.com/address/0x8f3cf7ad23cd3cadbd9735aff958023239c6a063) on Polygon, you would receive [aPolDAI](https://polygonscan.com/address/0x82E64f49Ed5EC1bC6e43DAD4FC8Af9bb3A2312EE) back.
[Here](https://docs.aave.com/developers/deployed-contracts/v3-mainnet/polygon#tokens) is a list of other commonly-issued aTokens.

aTokens are _receipt tokens_: they represent a claim on deposited assets.
When you want to [withdraw](https://github.com/aave/aave-v3-core/blob/f3e037b3638e3b7c98f0c09c56c5efde54f7c5d2/contracts/protocol/pool/Pool.sol#L197-L217) your deposit and claim its accumulated interest, your aTokens are [burned](https://github.com/aave/aave-v3-core/blob/f3e037b3638e3b7c98f0c09c56c5efde54f7c5d2/contracts/protocol/libraries/logic/SupplyLogic.sol#L131-L136).

One thing that makes Aave's aTokens interesting is that their balance automatically increases over time.
If you have (say) 100
[aPolWETH](https://polygonscan.com/address/0xe50fA9b3c56FfB159cB0FCA61F5c9D750e8128c8) today, you will have 102 aPolWETH in a year from now.
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
100e18 on disk. Rather, your balance is incremented by your deposit [_divided
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
[this](https://github.com/aave/aave-v3-core/blob/f3e037b3638e3b7c98f0c09c56c5efde54f7c5d2/contracts/protocol/tokenization/AToken.sol#L131-L139):

{% highlight javascript %}
super.balanceOf(user).rayMul(
  POOL.getReserveNormalizedIncome(_underlyingAsset)
);
{% endhighlight %}

`rayMul` just means "[multiply these values together then
divide by a
ray](https://github.com/aave/aave-v3-core/blob/f3e037b3638e3b7c98f0c09c56c5efde54f7c5d2/contracts/protocol/libraries/math/WadRayMath.sol#L65-L74)".

So this `balanceOf` function is simply multiplying two values
together. The first should be obvious: [it's just the user's balance in
storage](https://github.com/aave/aave-v3-core/blob/f3e037b3638e3b7c98f0c09c56c5efde54f7c5d2/contracts/protocol/tokenization/base/IncentivizedERC20.sol#L106-L108).

The second is less obvious. The logic for the getReserveNormalizedIncome function [looks like
this](https://github.com/aave/aave-v3-core/blob/f3e037b3638e3b7c98f0c09c56c5efde54f7c5d2/contracts/protocol/libraries/logic/ReserveLogic.sol#L40-L64) (indented to make it easier to read):

{% highlight javascript %}
MathUtils.calculateLinearInterest(
  reserve.currentLiquidityRate,
  reserve.lastUpdateTimestamp
).rayMul(
  reserve.liquidityIndex
);
{% endhighlight %}

So, the aToken balanceOf function is simply multiplying the stored
balance by the current liquidity index (incremented by whatever interest has not
yet been factored in).

Initially, this cancels out the effect of scaling down the balance, so that if
someone went to withdraw immediately after depositing they would get all of
their money back. E.g. a stored balance of
98.93e18 aPolyDAI would be multiplied by the liquidity index of 1.01083, resulting a
withdrawable balance of 100 DAI.

But over time, as the liquidity index increases, it results in a net positive aToken balance, since the stored balance is being multiplied by a larger number than it was initially divided by.

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

* but notice we can just compare the base balances and get the same result 95.23 / 90.70 == 1.05, i.e. Ben has 5% more than me
* this is because we multiply _both_ by the same factor to determine rebased balance!
* but what about at an arbitrary block in the past or future? We have no idea what total cumulative interest might be (or have been). True, but it doesn't matter because (again) both numbers are scaled up by that same rate. So it won't effect their ratio (which is all we care about when determining voting weight).



