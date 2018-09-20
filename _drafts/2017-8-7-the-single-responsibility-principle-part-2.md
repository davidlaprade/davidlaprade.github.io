---
title: "There is no Single Responsibility Principle"
tags: architecture
excerpt: There are four.
date: "2017-08-07"
---

__NOTE: this is the second of a two part series on the Single Responsibility
Principle. You can read the first part
[here](/blog/the-single-responsibility-principle-part-1).__

The [Single Responsibility
Principle](https://en.wikipedia.org/wiki/Single_responsibility_principle),
or SRP for short,
is a near-universally endorsed principle of software architecture.
It codifies the famous [Unix
maxim](https://en.wikipedia.org/wiki/Unix_philosophy#Origin) that units of
software should
"do one thing and do it well". It is the "S" in
[SOLID](https://en.wikipedia.org/wiki/SOLID_(object-oriented_design)).

Code that has a single responsibility is easy to reuse, refactor,
understand, and test. It is good code by just about any standard: code that
people want to write.

Described this way, the SRP sounds clear and obvious -- a platitude. It sounds
like there's nothing to talk about. But the devil's in the details.

The problem with the SRP is that "do only one thing" is not specific enough to be
useful. And even the most famous attempts to clarify it really [just push the
problem back](/blog/the-single-responsibility-principle-part-1). It may well be
that many people can successfully apply the SRP. But when they try to
_explain_ how they apply it, their attempts don't work with anything
other than the most contrived examples. This has lead many to feel that
the SRP is more "art" than "science".

I disagree.

I think the reason for all the trouble is that __there is no single
Responsibility Principle__. There are at least 4 distinct responsibility
principles:

* _The Single Function Principle_
* _The Single Implementation Principle_
* _The Single Use Principle_
* _The Specific Naming Principle_

This is why the SRP has been so resistant to clarification, and so hard for
beginners to absorb.

By distinguishing these principles we can get around these problems. They
allow us to pinpoint simple, objective evidence of SRP violation. Evidence like
this:

  * methods are >5 lines long (where 1 line is <= 80 characters)
  * local variables are used
  * classes are >100 lines long
  * there is nested logic
  * there are logical words ("and", "or") in the method name
  * return type varies
  * unit testing is difficult or impossible
  * etc

This evidence is
[defeasible](https://en.wikipedia.org/wiki/Defeasible_reasoning): it _suggests_
that the SRP has been violated. But it is not conclusive. Nevertheless, in view
of the alternative heuristics, this seems like progress.

My plan for this post is to lay out these four principles: to give examples of
them, and to show how the evidence above can help us detect their violation.
To the extent that a positive account of the SRP is possible, I think this is
the best I'll be able to do.

### The Single Function Principle

Suppose I ask you what you did this afternoon. You might say that
you did just one thing: you went grocery shopping. You could also honestly
say that you did many things:

* you looked through circulars to find foods on sale
* you decided what meals to have for the week
* you went through your pantry to find out what foods you needed for those meals
* you wrote those foods down on a list
* you drove to the market
* you picked up a cart
* you put the foods on your list into your cart
* you checked out
* ...

You get the idea. Speaking at the highest level, you did one thing. Speaking at
the lowest, you did many. The question is just which level you *should* be
talking at.

In ordinary speech, it seems pretty clear that when asked "what did you do this
afternoon" you should just say "I went grocery shopping". You should, in
other words, speak at the highest level you can while still answering the
question. In semantics, this principle is known as the [Gricean Maxim of
Quantity](https://www.sas.upenn.edu/~haroldfs/dravling/grice.html):

> be as informative as possible, with as few words as possible, without giving
> any more information than necessary

If you described your afternoon at a low-level, you'd be giving too much
information -- certainly: more than the person who asked you wanted to hear.
This is why the high-level description is called for.

It seems that something very much like the Gricean principle applies to software
design. Suppose we have a method like this:

{% highlight ruby %}
def scrape(url)
  response = HTTP.get(url)
  document = strip_headers(response)
  html = parse_html(document)
  extract_body(html)
end
{% endhighlight %}

Does this do one thing or many? Similar to our grocery example, the answer
depends on what level we describe it at. When described from a low
level, this method clearly does three things:

* makes a GET request to a URL
* removes the response headers from the response
* parses and returns the HTML body contained in the response

From a high level, however, this method does just one thing: it scrapes a page.

It seems to me that this method is entirely kosher with respect to the SRP. I
say this because, if it's not, I really can't think of any non-trivial method
that _would_ be kosher. Most actions have multiple steps, and certainly all
computer programs execute multiple actions. So, if it's not possible to have
multiple steps without violating the SRP, then _every_ program violates the SRP
-- even the really good ones. I consider this a
[_reductio_](https://en.wikipedia.org/wiki/Reductio_ad_absurdum). Hence, this
method does just one thing. So, we should be talking at a high level here.

This brings us to the _Single Function Principle_. It might be stated as follows:

> a method described at the highest level should have only one function, i.e. do
> only one thing

Another problem is posed by side effects. Consider a heart. What does it do?
It pumps blood. But it also makes a thumping sound.  What makes the
pumping the _function_ of the heart and the thumping the _side effect_? Why is
it not the other way around?

We encounter both of these problems when designing software that adheres to the
SRP.

  * example: groceries, heart function
  * code example: `def charge_and_notify` charge a card and send an email
  * evidence: logic in method name, doesn't fit "this X's the Y", fails the
    "natural selection" test

1.1 The Single Owner Principle
* this is what Bob Martin has in mind
* code should be owned by just one business position, as far as possible

2. The Single Implementation Principle
  == a method described at the lowest level should implement only one function
  * example: architect suburb, God method
  * carve nature at its joints: brangelina, action version ??
  * code example: wedding attendees
  * another code example: https://github.com/ascensionpress/harvey/blob/6e3cb10cbb4c6b178f9f1c484f23ad00bb0aafdd/app/controllers/api/v1/users_controller.rb#L6-L32
  * evidence: (assuming 80 char lines) methods > 5 lines, classes > 100 lines,
              use of local variables, passing non-trivial blocks to enumerators,
              unwrapped "data" (strings, numbers, etc) in code,
              "regions" of code demarcated by empty lines within methods

3. The Single Use Principle
  == a method should be used in only one way
  * example: tennis balls, tonic water, truthiness
  * code example: coupon discount, example where output type depends on input
    type
  * evidence: logic in code, difficulty unit testing, difficulty naming, confusing code, fails
    the "if you wrote out the steps, it'd be in there" test

4.
* The Specific Naming Principle
  == a method should be named as specifically as possible
  * example: ??
  * code example: Sandi Metz' `RandomHouse`
  * evidence:
