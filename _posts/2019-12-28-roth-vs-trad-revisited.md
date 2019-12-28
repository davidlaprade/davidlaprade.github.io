---
title: Traditional Retirement Accounts Are Probably Better Than Roth
tags: investing general
excerpt: "I now think most people should probably just use a mix of
Traditional and brokerage accounts for their retirement savings."
---

_DISCLAIMER: I am not a financial advisor and this is not financial
advice. Do your own research and consult with a qualified professional
before investing._

### Takeaway

Using Traditional retirement accounts to maximize tax deductions and then
investing the tax savings in a brokerage account beats comparable Roth-only
strategies by ~14% across income levels [0].

### Previous Approach

In my [previous post](/optimal-roth-vs-traditional-mix) I initially compared:

* maxing out Traditional Accounts
* maxing out Roth Accounts

and I found that the Roth approach was superior.

> Putting as much money as possible into Roth accounts will probably get you
the deepest into retirement.

But I did have a caveat:

> To keep the comparison fair, we might want to tweak the contribution to make
> sure that the additional taxes you incur on [the Roth-only] approach are
> somehow factored
> in -- that way you aren't in some sense investing "more" via the Roth
> approach, thus unfairly privileging the strategy.

The way I factored taxes into the Roth-only approach was to:

> contribute slightly less to the Roth accounts -- just enough less to pay the
extra taxes

That's one way to do it. Another way -- which I didn't consider then -- is to invest
the money you save on taxes from a Trad account, then use those additional
investments to fund your retirement. On this strategy, you would put your tax
savings into a regular (non-retirement) brokerage account, then strategically
withdraw from that brokerage account to pay for a portion of your retirement
expenses each year.

It turns out that this new strategy is significantly better than the Roth-only
approach. How much better?

### Results

![roth_vs_trad_result_graph]({{ site.baseurl }}/jekyll_img/roth_vs_trad_result_graph.svg)

The Trad+Brokerage strategy is the clear winner across income levels by a fairly
consistent margin of ~14% (on average) over the Roth-only strategy.

You'll probably notice that retirement gets shorter as income goes up.
This is because _spending_ tends to go up as income goes up. So I've assumed
that retirement expenses would be about 50% of pre-retirement income, i.e. a
family that makes $100k per year would spend ~$50k, a family that made $300k
would spend ~$150k. Needless to say, a family that only spends $50k a year can
last a whole lot longer on the returns of $49k/year retirement investments
($49k == two 401ks + two IRAs) than a family that needs $150k/year.

What if we hold retirement spending fixed? The Trad+Brokerage strategy is seen
to make an even bigger difference at higher income levels than at low.

![roth_vs_trad_result_fixex_expenses_graph]({{ site.baseurl }}/jekyll_img/roth_vs_trad_fixed_expenses_result_graph.svg)

This is because at higher income levels, you save even more money on taxes
(because you are in a higher tax bracket), and thus are able to contribute more
to the brokerage account.

### Why Does This Work?

The Trad+Brokerage strategy effectively is like being able to max out a Trad
account while still putting a small amount in a Roth. In other words: it gets
the benefits from both sides.

This is because long-term gains on regular old brokerage accounts
are [federal tax-free up to
$78.5k](https://www.fool.com/retirement/2018/12/09/long-term-capital-gains-tax-rates-in-2019.aspx) for
most people, and principle withdrawals are also untaxed. And if
you're investing the amount of money you _weren't_ taxed (because of the Trad
deduction), the brokerage account is effectively even better than a Roth
account -- it's like a Roth account that the federal government funds _for you_.

### How to Implement the Trad+Brokerage Strategy

1. Open a regular brokerage account at your bank. [2]
1. Figure out how much money you can afford to put towards Roth accounts.
1. Take the number from (2), and instead invest it in Trad accounts.
1. Figure out how much money you save in federal taxes because of the Trad
   investments. [3]
1. Take the tax savings from (4) and invest them in the brokerage account you just opened.
1. Repeat each year

The Roth number is important because it factors in federal taxes. If you can
afford to put X into a Roth, then you can afford to pay the income taxes on
X. And if you can afford to pay the income taxes, then you can afford to not
have that tax money. And if you can afford to not have the
tax money, then you can afford to put it into a brokerage account. Very simple.

### Benefits

The primary benefits of the Trad+Brokerage approach are:

1. **Longer retirement**
  * ~14% longer, as discussed
1. **More flexibility**
  * you can withdraw gains from a brokerage account without penalty prior to
    59.5, meaning you have more options to fund an early retirement
  * principle can be withdrawn tax-free from a brokerage account in case of an
    emergency
  * brokerage accounts, like IRAs, usually have fewer limitations to what
    funds they can invest in
1. **More availability**
  * anyone in any tax bracket can follow this strategy, whereas there are income
    limits being able to contribute to Roth accounts

### Methods

Where am I getting these numbers from?

These figures are coming from the output of a new retirement simulator[1] that I
wrote. I needed a more powerful tool than the [google
sheet](https://docs.google.com/spreadsheets/d/1BTxpTPcWo_49mpgjvHOl3uldeCp2guozpnRap4Uye-o/edit#gid=323340355)
I used in my last post to properly simulate the Trad+brokerage strategy -- one
that would allow me to do things like track gains/principle of individual
investments within a brokerage account in order to correctly estimate long-term
capital gains taxes, and withdraw from individual investments on a
First-In-Last-Out basis.

The simulator takes the following as input:

  * current annual income (pre-tax)
  * current Trad balance
  * annual Trad contribution
  * current Roth balance
  * annual Roth contribution
  * current age
  * retirement age
  * cost of living during retirement (in today's dollars)
  * expected stock returns (less inflation)
  * expected bond returns (less inflation)

The simulator will try to maximize tax-free withdrawals during retirement,
and withdraw from accounts in the following order:

1. Trad accounts up to the standard deduction (untaxed)
1. Trad accounts up to the required minimum distribution (taxed, but it's
   required)
1. Brokerage accounts within the first long-term capital gains bracket (untaxed)
1. Trad accounts again, if more is needed (taxed)
1. Roth accounts (untaxed)

Additionally, the simulator will proactively re-invest Trad funds within the
brokerage account if there is a required minimum distribution in excess of what
is actually needed for living expenses.

---

[0] As in: it will last you 15% deeper into retirement than a
Roth-only approach.

[1] I hope to either open-source this code, or offer it as a service at some
point soon. I will update this blog post when I do.

[2] I use Fidelity. It takes all of 5 minutes to open a brokerage account with
them. Here's a [direct
link](https://www.fidelity.com/trading/the-fidelity-account).

[3] To figure that out with the retirement simulator, you can run:

{% highlight ruby %}
  TaxCalc.income_tax(income) - TaxCalc.income_tax(income - trad_amount)
{% endhighlight %}

