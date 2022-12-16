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
aToken [TODO link to our contract in github].

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

In other words, __the liquidity index for a certain asset is the total amount of interest ever earned by
deposits of that asset into Aave__ -- in this case expressed as a
[ray](https://github.com/aave/aave-v3-core/blob/f3e037b3638e3b7c98f0c09c56c5efde54f7c5d2/contracts/protocol/libraries/math/WadRayMath.sol#L17)-based percentage.

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
It happens in code
[here](https://github.com/aave/aave-v3-core/blob/f3e037b3638e3b7c98f0c09c56c5efde54f7c5d2/contracts/protocol/libraries/logic/ReserveLogic.sol#L291-L297).

{% highlight js %}
// Calculate the amount of interest that accrued since the last time
// anything happened. The amount will be a ray-based percentage.
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

Increasing the liquidity index has an immediate consequence on aToken balances,
as we'll see in the next section.

#### Scaled Balances

The second key thing to understand about Aave is that it scales user balances
down by the liquidity index before writing them to storage.


