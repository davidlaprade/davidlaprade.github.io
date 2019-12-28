---
title: Roth vs Traditional Retirement Accounts
tags: investing general javascript
excerpt: "How to determine the optimal mix of retirement accounts for your
circumstances."
---

_DISCLAIMER: I am not a financial advisor and this is not financial
advice. Do your own research and consult with a qualified professional
before investing._

### TLDR

Putting as much money as possible into Roth accounts will
probably get you the deepest into retirement. This seems to
hold true for people who can afford to max out all of their accounts, and also
for people who can't.

I created [this Google
Sheet](https://docs.google.com/spreadsheets/d/1BTxpTPcWo_49mpgjvHOl3uldeCp2guozpnRap4Uye-o/edit#gid=323340355) to run simulations at different income levels to find out how
well different strategies performed because I didn't trust the calculators I
found online.

Please try the sheet out
for yourself, check my math, and let me know if I've missed anything! You can
find a list of my assumptions below.

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
* how much you can afford to contribute to retirement saving each year
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
* whether social security will be around when you retire
* what your state income taxes are when you are working
* what your state income taxes are when you retire

As if that weren't bad enough, the issue is compounded by the fact that tax law:

* can (and does) change
* is exceedingly complicated, and so it isn't quick to calculate taxes owed
* makes it hard to determine how much one would need to withdraw from a
  Traditional account in order to have a certain amount available to spend after
  taxes

But saving for retirement is too important to let these hurdles deter us.
It can mean the difference between:

* retiring at age 50 and retiring at 70
* being able to pursue one's retirement dreams (e.g. travel, hobbies) and
  wasting the last years of your life in a state of bored loneliness
* living on your own and living in a nursing home
* leaving an inheritance to your children and leaving them with nothing, or even debt

These are not differences that I take lightly.

Moreover, all the retirement investment calculators I found online were either
[too
basic](https://www.edwardjones.com/preparing-for-your-future/calculators-checklists/calculators/retirement-savings-calculator.html)
or [too opaque](http://www.nestegged.com/Home/Allocate) to
give me any real confidence in their results. So I decided to make my own.

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

function AFTER_TAX(income) { return income - INCOME_TAX(income) };

{% endhighlight %}

The next step was to be able to quickly figure out how much one would need to
withdraw from a Traditional plan in order to have a certain amount after taxes
were subtracted, e.g. to pay for one's living expenses in retirement.

I should emphasize that given US tax law, this is not an easy calculation. It
has always been the thing that stopped me when I wanted to try to
run these numbers in the past. That's because there's a kind of vicious
circularity to it. If you want to have $50k in after-tax money, you obviously
can't earn just $50k in income because that doesn't account for the taxes you'll
have to pay. So, suppose you start with $52k in income. The taxes on that
(excluding FICA) are ~$2980, leaving you with ~$49,020. But now, you can't just
increase your income by $1k to cover the difference, because by increasing your
income you also increase your taxes!

If you look at the problem algebraically, you can easily see why it's so
challenging. This is the formula for the after-tax amount on an income:

afterTax = beforeTax - INCOME_TAX(beforeTax)

So, suppose that you want to solve for `beforeTax`. This would require you to
isolate `beforeTax` on one side of the equation. That's just basic algebra. But
there's no way to do that here, since one instance of `beforeTax` is bound to
the `INCOME_TAX` function. There's no way to factor it out.

Fortunately for us, now that we have a quick way to calculate tax amounts on an
income, we can just brute-force the problem. We can just write a script to
intelligently _guess_ what the `beforeTax` amount will be.

That's exactly what `WITHDRAW_FOR_AFTER_TAX_AMOUNT` does:

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

With this, we've removed two of the biggest hurdles to modeling
different retirement savings strategies.

### Simplifications

These improvements notwithstanding, there are still a *lot* of complicating
factors to our model.

Given all the complications, my goal was to be able to run
simulations of retirement saving that were _close enough_. I wanted to get the
big things right and not sweat the small stuff.

To do this, I assumed the following:

* the current tax laws won't change, in particular:
  * the brackets don't change
  * the standard deduction amount doesn't change
* you take the standard deduction each year
* you're currently married, will stay married, and file joint tax returns
* your salary keeps pace with inflation
* social security benefits keep pace with inflation
* the max-contributions for retirement accounts will (at least) keep pace with
  inflation (IRA contribution limits have averaged a [6% yearly increase](https://dqydj.com/history-of-contributions-ira-limit/), [401ks a 4%
  increase](http://www.pensions123.com/index.php/401k-limit-graph), both above the 100-year average of [3.2% inflation](https://inflationdata.com/Inflation/Inflation_Rate/Long_Term_Inflation.asp))
* you don't withdraw from your retirement accounts before you can take qualified
  distributions [at 59 and a half years
  old](https://www.irs.gov/retirement-plans/retirement-plans-faqs-regarding-iras-distributions-withdrawals), so you don't pay any penalties
* during retirement, you spend money in this order of preference: social
  security benefits, retirement
  income, traditional accounts, then finally roth accounts
* you make your contributions in one lump sum at the beginning of each year
* your contribution amounts don't change over time (relative to inflation) --
  this means, in particular, that you don't take advantage of ["catch-up"
  contributions](https://www.irs.gov/retirement-plans/plan-participant-employee/retirement-topics-catch-up-contributions)
  when you're older
* your investment portfolio won't change composition before retirement,
  e.g. in the way
  it's normally recommended that one slowly transition to lower-risk assets as
  retirement approaches
* non-IRA retirement accounts (e.g. 401k, 403b, etc.) are all rolled over into
  their corresponding IRAs (i.e. a traditional 401k gets rolled over into a
  traditional IRA), and so the laws governing IRAs apply to all of the retirement
  funds you accumulate
* you don't collect Social Security until [you qualify for full benefits at age
  66](https://www.ssa.gov/planners/retire/retirechart.html)
* you live in a state without income taxes

Any of all of these assumptions might be false. To the extent that they are,
this admittedly reduces the accuracy of the simulator.

But I contend that with respect
to answering our questions they constitute at worst a rounding error. They don't
make a big difference.

### Running Simulations

The next step was to actually run some simulations. Ideally, the simulation
would take as input the variables noted above (current age, age of retirement,
cost of living, etc.) and produce as output the age at which one would run out of
money. This would allow me to have a quick, objective way to compare different
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
sheet](https://docs.google.com/spreadsheets/d/1BTxpTPcWo_49mpgjvHOl3uldeCp2guozpnRap4Uye-o/edit#gid=323340355).

Feel free to make a copy of the doc, change the parameters, check my math, and get
some customized results! And please let me know what you think!

Caveat: programming in Google Sheets/Excel _is awful_, so I apologize in
advance for formulas that are unintuitive and poor performance. I felt the
benefits were worth these trade-offs.

### Results

For these particular simulations, I've assumed the following (in addition to the
global simulator assumptions above):

* you start saving at age 30 (i.e. you have no prior retirement balance)
* you retire at 60
* inflation is 3%
* you and your spouse can each contribute to a 401k and an IRA
* your non-retirement portfolio averages 7% annually
* your retirement portfolio averages 3% annually
* you need $50k per year to live your desired retirement lifestyle
* you have no company match on your traditional account contributions
* your receive the equivalent of $2607 (in today's dollars) in Social Security
  benefits each month beginning at age 65, estimated with
  [this](https://www.ssa.gov/OACT/quickcalc/index.html)

Making assumptions about these details is inevitable for anyone trying to decide
whether Roth or Traditional accounts is better. I believe they are reasonable
approximations for many people.

So that we're not comparing apples to oranges, however,
we need to separate out the scenarios in which you can max out all your accounts
with those in which you can't.

__Results Part I: You Can Max Out Your Accounts__

Suppose that you can afford to max out all of your tax-shielded retirement investment
accounts. Lucky you! Assume, in particular, that:

* you make an income of $100k ($50k per spouse)

What account, or mix of accounts, is best?

Let's start with an uncomplicated strategy: max out all of the Traditional
accounts you have access to. Here's what that looks like:

<div class="well">
  <div class="well-header">SIMULATION #1 - Traditional Accounts Only</div>

  Each year:<br>

 * $37k is contributed to 401ks ($18.5k per spouse) and then rolled over into Traditional IRAs<br>

 * $11k ($5.5k per spouse) is contributed to Traditional IRAs directly<br>

 * effectively: $48k is contributed to Traditional IRAs per year on this
   approach<br>

<br>
<strong>RESULT:</strong> This approach would last you until you were <strong>107</strong> years old
</div>

Since almost no one lives this long, this strategy will very likely last your
entire life. Excellent.

Now, what happens if we max out Roth accounts?

Assume that at work you have access to a Roth 401k option and max it out. (It
doesn't matter that most people don't: Traditional 401k's can be rolled over
into Traditional IRAs and then converted into Roth IRA's without penalty if you
pay the income taxes on them.<sup>0</sup>)

To keep the comparison fair, we might want to tweak the contribution to make sure
that the additional taxes you incur on this approach are somehow factored in --
that way you aren't in some sense investing "more" via the Roth approach, thus
unfairly privileging the strategy.

One way to do this is to contribute slightly less to the Roth accounts -- just
enough less to pay the extra taxes.

On this approach, your taxable income doesn't change (it stays at 100k) because
you have to pay income tax on your Roth contributions. This increases your costs by:

INCOME_TAX($100,000) - INCOME_TAX($100,000 - $48,000) = $5760

(We use $48k here, because that's the max 401k plus the max IRA contribution.)
So, you're spending $5760 more in taxes if you max our your Roth accounts vs.
maxing our your Traditional accounts.

So, let's suppose that you just contribute $5760 less to your 401k to make up
for these additional taxes. This still allows you to contribute $31,240 to your
Roth, plus an additional $11k for the Roth IRA
contribution.  You then pay the additional taxes with the leftover money you
didn't invest.

What does this look like?

<div class="well">
  <div class="well-header">SIMULATION #2 - Roth Accounts Only (handicapped)</div>

  Each year:<br>

 * $31.2k is contributed to Roth 401Ks<br>

 * $11k is contributed to Roth IRAs<br>

 * effectively: $42.4k is contributed to Roth accounts per year on this
   approach<br>

  * the ~$5.6k that wasn't invested is used to pay the additional taxes you
    would owe on this strategy compared to Strategy #1<br>

<br>
<strong>RESULT:</strong> On this approach <strong>you would never run out of money</strong>.
</div>

Never? _Really_: never. Not unless you started spending a lot more. To give you an
idea of the result here, at 130 years old, your Roth account would have nearly
$18 million dollars in it. And this is _with_ the handicap.

On the other hand, since we're assuming that you make enough money to max out
your investments -- no matter what approach you take -- one could reasonably
argue that it really _would_ be fair to compare the Traditional-only approach to
one in which the additional income tax of rolling over all 401k assets into Roth
accounts doesn't lessen the amount you can put away.

I think this is a fair objection. There's no point placing an artificial
handicap on Roth accounts. If they allow you to put more money away, and you
have the money to do so, then that's
a benefit that should be allowed to distinguish them from Traditional accounts
in the simulation.

So, suppose we did that. What is the result?

<div class="well">
  <div class="well-header">SIMULATION #3 - Roth Accounts Only (no handicap)</div>

  Each year:<br>

 * $37k is contributed to 401ks and then rolled over into Roth IRAs<br>

 * $11k is contributed to Roth IRAs directly<br>

 * effectively: $48k is contributed to Roth IRAs per year on this
   approach<br>

 * the ~$5.6k additional taxes compared to Strategy #1 are paid out of
   pocket<br>

<br>
<strong>RESULT:</strong> On this approach <strong>you would never run out of money</strong>.
</div>

No surprise, this one also reaches escape velocity. By 130 years old, your Roth
would have over $22 million dollars in it.

So far it's looking like Roth-only approaches have the upper hand.

But what about a mixed approach? Does that have any benefits? What if you maxed
out the 401k and the Roth IRA, but didn't convert any of the 401k to a Roth?

<div class="well">
  <div class="well-header">SIMULATION #4 - Mixed Contributions</div>

  Each year:<br>

 * $37k is contributed to 401ks<br>

 * $11k is contributed to Roth IRAs<br>

<br>
<strong>RESULT:</strong> This approach would last you until you were <strong>138</strong> years old
</div>

So, by simply switching your contributions from a Trad IRA to a
Roth IRA, you get you an additional _31 years_ of retirement over Strategy #1,
which was otherwise the same.

So, the takeaway from the simulations is this:

> If you have the money to do so, you should do everything you
> can to fund Roth accounts.

But perhaps things are different when you can't afford to max out all of your
accounts. Perhaps in a lower income bracket, the increased amount of money
that one can contribute to a Traditional account and lower tax bracket would
make Traditional accounts better investment vehicles than Roth accounts.

__Results Part II: You Can't Max Out Your Accounts__

Suppose you cannot max out your retirement accounts and that:

* you make a combined income of $50k ($25k per spouse)

Suppose that you can only afford to contribute $7000 in after-tax dollars (for
whatever reason) to retirement each year.

$7k in after-tax dollars is equal to what in before-tax dollars?
Put another way: how much less income would you need to make in order for your
after-tax amount to be $7k lower?

It's important to know the answer to this question, so that we can properly
compare Trad contributions to Roth contributions.

Turns out that's pretty easy to calculate the "before-tax" value of $7k with
our functions. Start with the after-federal-tax value of a $50k income:

```
= AFTER_TAX(50000)
```

The after-tax value is $47,261.

So, we want $7k less than that. That's $40,261.

Now, how much would we need to make in order to end up with $40,261 after
federal taxes? We can find that like this:

```
= WITHDRAW_FOR_AFTER_TAX_AMOUNT(40261)
```

Answer: we would need to make $42,067 to end up with $7k less in after-tax money.

So, we would need to reduce our federally taxable income from $50,000 to
$42,067 -- a difference of $7,933 -- to have $7k less after-tax.

Altogether we have:

```
50000 - WITHDRAW_FOR_AFTER_TAX_AMOUNT(AFTER_TAX(50000) - 7000) = 7933
```

At $50k in income, $7k in after-tax dollars is equal to $7,933 in before-tax
dollars.

So, what would our retirement look like if we contributed $7,933 to a
Traditional account each year?

<div class="well">
  <div class="well-header">SIMULATION #5 - Traditional Only Contributions</div>

  Each year:<br>

 * $7,933 is contributed to Traditional IRAs<br>

<br>
<strong>RESULT:</strong> This approach would last you until you were <strong>71</strong> years old
</div>

Now, knowing that $7933 (before tax) equals $7000 (after tax), we can compare
this approach to a Roth-only approach.

<div class="well">
  <div class="well-header">SIMULATION #6 - Roth Only Contributions</div>

  Each year:<br>

 * $7,000 is contributed to Roth IRAs<br>

<br>
<strong>RESULT:</strong> This approach would last you until you were <strong>75</strong> years old
</div>

Pretty incredible. Investing the same amount of money (relative to taxes) in
Roth accounts buys you 4 years over the Traditional-only approach.

What about a mixed approach? Suppose we were to split our contributions up
50:50, what would that look like?

To keep the comparison fair, we'll still try to contribute the "equivalent" of
$7k in after-tax dollars. So, we'll be contributing $3.5k to the Roth, and the
"equivalent" of $3.5k in before-tax dollars.

To figure out what $3.5k (after-tax) is in before-tax dollars at the $50k income
level, we can use a formula like the one above:

```
= 50000 - WITHDRAW_FOR_AFTER_TAX_AMOUNT(AFTER_TAX(50000) - 3500)
```

Answer: $3,977 in before-tax dollars is equivalent to $3,500 in after-tax
dollars at the $50k income level.

Putting these numbers together, we can run a mixed simulation:

<div class="well">
  <div class="well-header">SIMULATION #7 - Mixed Contributions</div>

  Each year:<br>

 * $3,977 is contributed to Trad IRAs<br>
 * $3,500 is contributed to Roth IRAs<br>

<br>
<strong>RESULT:</strong> This approach would last you until you were <strong>71</strong> years old
</div>

There is no difference, then, comparing this to the Traditional-only approach.
I found that surprising.

### Conclusion

In conclusion, I've found that __Roth accounts outperform Traditional accounts__
in most circumstances, at least in regards to how deep they
get you into retirement. This is the case both for people who can afford to max
out their accounts, and people who cannot.

This conclusion obviously comes with the caveat that I've had to make a lot of
assumptions which may or may not be true.

Beyond this, there are some additional inaccuracies in the simulator worth
considering:

* no state or local income taxes are factored in
* the tax bracket amounts aren't effected by inflation
* social security benefits are not taxed as income
* there may be some circumstances in which it's best to withdraw from traditional
  IRAs first but _only_ up to the 22% tax bracket, to minimize taxes

Unfortunately, I believe I've reached the limits of what can be (sanely)
accomplished with a Google Sheet. The price of accuracy is opacity: to get even
more accurate simulations I'd need to write more custom code, which would make
the simulator less transparent and auditable to people.

Hopefully, though, this approach has been good enough to shift the burden of
proof to those who would deny that a Roth-only approach is best for most people.

---

[0]
There is currently an option to [convert existing Traditional assets into Roth
assets](https://www.irs.gov/retirement-plans/retirement-plans-faqs-regarding-iras-rollovers-and-roth-conversions). This can be done without penalty, but requires you to pay
income taxes (but not FICA taxes) on those assets.

[IRS Pub 590-A
(2017)](https://www.irs.gov/publications/p590a#en_US_2017_publink1000231029) says:

> You may be able to convert amounts from either a traditional, SEP, or SIMPLE IRA
into a Roth IRA. [. . .] You must include in your gross income distributions from a
traditional IRA that you would have had to include in income if you hadn’t
converted them into a Roth IRA.
