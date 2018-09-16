---
title: Roth vs Traditional Retirement Accounts
tags: investing general javascript
excerpt: "How to determine the optimal mix of retirement accounts for your
circumstances."
---

_DISCLAIMER: I am not a financial advisor and this is not financial
advice. Do your own research and consult with a qualified professional
before investing._

### Background

There are two main types of tax-advantaged retirement accounts:

1. __Traditional Accounts__
  * money is contributed "before tax"
  * grows tax-free
  * is taxed as income when withdrawn
  * has to be withdrawn by a certain age
2. __Roth Accounts__
  * money is contributed "after tax"
  * grows tax-free
  * can be withdrawn tax-free
  * has no required withdrawals

The (simplified) descriptions above hopefully show that it's not entirely clear
which type of account is best for retirement savings.

Suppose your goal is to have as long a retirement as possible. Would it be best
to put all of your money
in Traditional accounts? Roth accounts? A mix of the two? Does it even make a
difference?

That depends on a lot of things, for example:

* how much you currently earn (pre-tax)
* how much you can afford to contribute each year
* how much your employer contributes each year
* how much you expect to earn at the time of retirement
* whether you plan to work in retirement
* how much you expect to earn during retirement
* what your current living expenses are
* how you expect to live during retirement
* whether/when you are married
* how much it would cost to live your retirement lifestyle now
* what you think inflation is
* how much money you expect your investments to make
* how old you are
* how long you expect to work
* how long you expect to live
* what kind of investment accounts you have access to (IRAs, 401ks, 403bs, etc)

As if that were bad enough, the issue is compounded by the fact that tax law:

* is exceedingly complicated
* can (and does) change
* does not make it quick to calculate taxes owed
* makes it hard to determine how much one would need to withdraw from a
  Traditional account in order to have a certain amount available to spend after
  taxes

But saving for retirement is too important to let these hurdles deter us.
It can mean the difference between:

* retiring at age 50 and retiring at 70
* being able to pursue one's retirement dreams (e.g. travel, hobbies) and not
* living on your own and living in a nursing home
* leaving an inheritance to your children and leaving them with debt

These are not differences that I take lightly.

### Steps Towards an Answer

The first step was to be able to quickly calculate the taxes on a given income.
Here's the code to do that:

{% highlight javascript %}
function ANNUAL_INTEREST(principle, rate, years) { return(principle * Math.pow(1 + rate, years)) };

function BRACKET(n) {
  if (n==6) { return {number: 6, lowerBound: 600001, upperBound:   null, rate: 0.37} } else
  if (n==5) { return {number: 5, lowerBound: 400001, upperBound: 600000, rate: 0.35} } else
  if (n==4) { return {number: 4, lowerBound: 315001, upperBound: 400000, rate: 0.32} } else
  if (n==3) { return {number: 3, lowerBound: 165001, upperBound: 315000, rate: 0.24} } else
  if (n==2) { return {number: 2, lowerBound:  77401, upperBound: 165000, rate: 0.22} } else
  if (n==1) { return {number: 1, lowerBound:  19051, upperBound:  77400, rate: 0.12} } else
  if (n< 1) { return {number: 0, lowerBound:      0, upperBound:  19050, rate: 0.10} };
}

function bracketFromIncomeAmount(income) {
  if ( income > BRACKET(6).lowerBound ) { return BRACKET(6) } else
  if ( income > BRACKET(5).lowerBound ) { return BRACKET(5) } else
  if ( income > BRACKET(4).lowerBound ) { return BRACKET(4) } else
  if ( income > BRACKET(3).lowerBound ) { return BRACKET(3) } else
  if ( income > BRACKET(2).lowerBound ) { return BRACKET(2) } else
  if ( income > BRACKET(1).lowerBound ) { return BRACKET(1) } else
                                        { return BRACKET(0) };
}

function INCOME_TAX(income, accumulatedTax) {
  standardDeduction = 24000
  if (accumulatedTax == null) income -= standardDeduction
  accumulatedTax = accumulatedTax || 0
  if (income <= 0) return accumulatedTax
  var bracket = bracketFromIncomeAmount(income);
  var taxInThisBracket   = (income - bracket.lowerBound) * bracket.rate;
  var taxInLowerBrackets = INCOME_TAX(bracket.lowerBound, accumulatedTax);
  return taxInThisBracket + taxInLowerBrackets;
};

{% endhighlight %}

The next step was to be able to quickly figure out how much one would need to
withdraw from a Traditional plan in order to have a certain amount after taxes
were subtracted, e.g. to pay for one's living expenses in retirement.

That's what `WITHDRAW_FOR_AFTER_TAX_AMOUNT` does:

{% highlight javascript %}

function WITHDRAW_FOR_AFTER_TAX_AMOUNT(targetAfterTax, highGuess, lowGuess) {
  // how much do I need to withdraw to be able to cover my taxes and still have x to spend
  highGuess = highGuess || BRACKET(6).rate // the effective rate can't be higher than the BRACKET(6).rate
  lowGuess  = lowGuess  || 0               // the effective rate could be lower than the BRACKET(0).rate
  var guess         = (highGuess - lowGuess)/2.0 + lowGuess
  var guessAmount   = targetAfterTax / (1 - guess);
  if (highGuess == lowGuess) return guessAmount
  var guessTax      = INCOME_TAX(guessAmount);
  var guessAfterTax = guessAmount - guessTax;
  var guessDelta    = guessAfterTax - targetAfterTax;
  if (Math.abs(guessDelta) <= 1) { return guessAmount; } // close enough
  if (guessAfterTax > targetAfterTax) { // after tax was too high, try something lower
    return WITHDRAW_FOR_AFTER_TAX_AMOUNT(targetAfterTax, guess, lowGuess);
  } else { // after tax was too low, try something higher
    return WITHDRAW_FOR_AFTER_TAX_AMOUNT(targetAfterTax, highGuess, guess);
  }
}

{% endhighlight %}

With this, I now had removed two of the biggest practical hurdles to modeling
different retirement savings strategies.

### Simplifications

Given all the complications, my goal was to be able to run
simulations of retirement saving that were _close enough_. I wanted to get the
big things right and not sweat the small stuff.

To do this, I assumed the following:

* the current tax laws won't change
* you're currently married and will stay married
* both your salary and retirement account max-contributions will (at least) keep pace with
  inflation (IRA contribution limits have averaged a 6% yearly increase, 401ks a 4%
  increase)
* you take the standard deduction each year (and the standard deduction doesn't
  change)
* you don't withdraw from your retirement accounts before you can take qualified
  distributions, so you don't pay any penalties
* during retirement, you spend money in this order of preference: retirement
  income, traditional accounts, roth accounts
* you make your contributions in one lump sum at the beginning of each year
* your investment portfolio won't change composition before retirement,
  e.g. in the way
  it's normally recommended that one slowly transition to lower-risk assets as
  retirement approaches
* non-IRA retirement accounts (e.g. 401k, 403b, etc.) are all rolled over into IRAs,
  and so the laws governing IRAs apply to all of the retirement funds you accumulate

Any of all of these assumptions might be false. But I contend that with respect
to answering our questions they constitute at worst a rounding error.

### Running Simulations

The next step was to actually run some simulations. Ideally, the simulation
would take as input the variables noted above (current age, age of retirement,
cost of living, etc.) and produce as output the age at which one would run out of
money. This would allow me to have a very quick way to compare different
strategies.

I also wanted to allow others to run simulations. This was in part out of a
desire to help people with the same questions as me but different parameters:
people who were older/younger, with higher/lower cost of living, etc, who
wouldn't directly benefit from simulations of my unique situation.  But it was
also somewhat selfish: the more people running the simulations, the more likely
others would notice (and correct) any mistakes I made.

That made Google Sheets a fairly obvious choice:

* it is easy to share
* everyone with a browser can run it
* most people know how to copy a sheet and edit it
* my custom javascript functions could easily be uploaded and used
* my formulas would be public and fairly easy to understand without programming
  knowledge

This lead to the creation of [this
sheet](https://docs.google.com/spreadsheets/d/13mYJGdpsJ5jbutWnDaP5GNBr9-JnGcDVpgh4EhOqUY8/edit?usp=sharing).

Feel free to make a copy of the doc, change the parameters, check my math, and get
some customized results! And please let me know what you think!

### Results

So, with this tool available, what is the takeaway? Can we settle any of the
questions raised at the beginning of this post?

Here are some conclusions I've drawn:
* 

So that we're not comparing apples to oranges,
we need to separate out the scenarios in which you can max out all your accounts
with those in which you can't

For these particular simulations, I've assumed (in addition to the global
assumptions above):

* you start saving at age 30
* you retire at 60
* inflation is 3%
* you can contribute to a 401k plan as well as IRAs
* your non-retirement portfolio averages 7% annually
* your retirement portfolio averages 3% annually
* you need $50k per year to live your desired retirement lifestyle
* you make an income of $100k ($50k per spouse)
* you have no company match on your traditional account contributions

These assumptions are reasonable because...

# CAN MAX OUT
Suppose that you can afford to max out all of your tax-shielded retirement investment
accounts. Lucky you! What account, or mix of accounts, is best?

TRAD ONLY - ($36 401ks, $11 trad IRAs) = 100 years old

There is currently an option to convert existing Traditional assets into Roth
assets. [LINK??] This can be done without penalty, but requires you to pay
income taxes on those assets. Let's assume that you take this option. And, for
the sake of simplicity, let's also assume that you are able to convert your
Traditional assets each year immediately after contributing them.

To keep the comparison fair, we might want to tweak the contribution to make sure
that the additional taxes you incur on this approach are somehow factored in.
One way to do this is to contribute slightly less to the 401k that you're
rolling over -- just enough to pay the taxes on it.

This is actually a surprising difficult thing to calculate, but here's how to do
it.

> what is the 401k contribution amount (under $36k) such that:
 salary - TAXES(salary - contribution_amount) == 

ROTH ONLY 1

On the other hand, since we're assuming that
you make enough money to max out your investments -- no matter what approach you
take -- one could reasonably argue that we should consider a scenario in which
the additional income tax doesn't lessen the amount you can put away. I think
this is a fair point.

ROTH ONLY 2 ($36k rolled over from 401ks into roth + $11k roth IRA = $47k)

to keep your after tax
ROTH ONLY - ($36 401ks converted to roth, $11 roth IRAs) = ??
TRAD ONLY 2 - ($11 trad IRAs) = 100 years old
ROTH ONLY 2 - ($11 roth IRAs) = 73 years old
MIX - (

What is a fair comparison? Trad accounts have higher limits than Roth accounts.
So is it fair to compare, say, a 401k with an $18,500 limit (as of now), and a
Roth IRA with an $5,500 limit?  On the one hand, those *are* the
options you have, so if one is obviously better, then that's the better option.


It's obvious that the vastly different contribution amounts make this like
comparing apples to oranges. In some cases, you get more money now than in
others

# CANNOT MAX OUT
Suppose that you can only afford to contribute $7000
in after-tax dollars (for whatever reason)

$7k in after-tax dollars is equal to what in before-tax dollars?
== how much income would you need to lose in order for your after-tax amount
to be $7k lower?

Turns out that's pretty easy to calculate:

```
=100000-WITHDRAW_FOR_AFTER_TAX_AMOUNT(100000-INCOME_TAX(100000)-7000)
```

At this income, $7k in after-tax dollars is equal to $7,950 in before-tax
dollars.

ROTH ONLY ($7000) - 67.79 years
MIX ($3500 ROTH, $3977 TRAD) - 67.69 years
TRAD ONLY ($7950) - 66.78 years
