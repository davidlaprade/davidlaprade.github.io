---
title: "Better Debugging in Forge Fork Tests"
tags: crypto
excerpt: How to get introspective access to contracts you can't change.
---

[Forge](https://github.com/foundry-rs/foundry/tree/master/forge) is an amazing library for EVM development, and its fork tests are incredibly useful.
But fork tests have the limitation that you cannot add `console.log` statements into the forked contracts that your tests interact with.
Afterall, that code is already on-chain – your tests are just reading it and interacting with it.

This stinks because logging is the primary debugging tool in EVM development.
And in really complicated 3rd party contracts, it can be nearly impossible to figure out what’s going on without it.

How can we get around this problem?

### Solution

1. find the uncompiled 3rd party source code (either etherscan or github)
1. temporarily add the 3rd party code as a dependency/submodule of your codebase (if not already)
1. edit the 3rd party code to add logging statements where you need insight
1. within the fork test, import and deploy the debug-friendly submodule contracts
1. `vm.etch` the debug-friendly bytecode to the actual addresses on the forked network
1. run the test

Bingo bongo, you’ve got logs!

The actual addresses will retain all of the state (i.e. storage) that they formerly had and will continue to function as normal – after all, the code should be identical except for your no-op console.log statements.
But now you get to see what’s going on!

### Example

I recently did this for [some code](https://github.com/ScopeLift/flexible-voting/blob/ef950394f5e560ec438890d07e60d40ab399c81a/test/ATokenFlexVotingFork.t.sol#L85-L88) I was working on for an Aave grant.

I couldn’t figure out why a `pool.borrow` call was failing.
Aave’s [code abstraction](https://github.com/aave/aave-v3-core) is really great.
But all that abstraction can be difficult to reason about when you can’t sanity check execution state.
I was finding it hard to hold everything accurately in my head.

So I just imported the `Pool` contract into my fork test, added some temporary console.log statements in key places in Pool.sol locally, deployed it with the same constructor arguments as the real thing, then [etched the bytecode](https://book.getfoundry.sh/cheatcodes/etch) to the actual Aave Pool address.

{% highlight java %}
vm.etch(
  // The actual Pool address on-chain I wanted insight into.
  address(pool),
  // Deploy the new code with console.logs and replace the
  // bytecode at the address above.
  address(new Pool(pool.ADDRESSES_PROVIDER())).code
);
{% endhighlight %}

Then when I re-ran my fork tests my logs appeared, exposing the key Pool context I needed.
I could finally figure out what was going on!

This approach to debugging fork tests generalizes.
Since `etch` doesn't modify storage and you're otherwise deploying identical code, these kinds of changes are no-ops.
The hardest part is just making sure you're using [the correct constructor args](https://github.com/ScopeLift/flexible-voting/blob/ef950394f5e560ec438890d07e60d40ab399c81a/test/ATokenFlexVotingFork.t.sol#L90-L110).

This is obviously all temporary.
You don’t need to keep the 3rd party code as a dependency/submodule of your repo.
Nor do you need (or want) to permanently etch local modifications to an address in a fork test.
You do these things to get a better understanding of the contracts you’re interacting with locally, then you undo them.
Once you’ve climbed the ladder, you can kick it away.
