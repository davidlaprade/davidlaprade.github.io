---
title: "There is no Single Responsibility Principle"
tags: architecture
excerpt: There are 3.
date: "2017-08-07"
---

0.
* define SRP: Unix maxim of "do one thing and do it well"
  * SRP code is reusable, refactorable, easy to understand and test
  * "do one thing" is not specific enough to be useful
  * famous attempts to make it more specific do not succeed, e.g. Uncle Bob
  * why? is this art not science? -- no, that's a cop out
  * they fail b/c there are really 3 distinct "responsibility" principles
    * The Single Function Principle
    * The Single Implementation Principle
    * The Single Use Principle
    * The Specific Naming Principle (?)
  * these principles each lead to simple, objective forms of evidence
    * verbosity (of implementation, method name)
    * logic (in implementation, in method name)
    * use of local variables
    * difficulty unit testing
* road map
  * these principles, what they are, examples, and the evidence they lead to
  * software design often requires conceptual analysis

1. The Single Function Principle
  == a method described at the highest level should have only one function
  * example: groceries, heart function
  * code example: `def charge_and_notify` charge a card and send an email
  * evidence: logic in method name, doesn't fit "this X's the Y", fails the
    "natural selection" test

2. The Single Implementation Principle
  == a method described at the lowest level should implement only one function
  * example: architect suburb, God method
  * code example: wedding attendees
  * evidence: (assuming 80 char lines) methods > 5 lines, classes > 100 lines,
              use of local variables

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
