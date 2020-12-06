---
title: "Don't Hard Code Data"
tags: architecture
excerpt: "Why and how to avoid it"
---

By data, I basically mean anything that could be assigned as the value of a variable. The integer `3`. The float `3.0`. The string `"three"`. The symbol `:three`. Etc.

Data is hard-coded when it is written in the source code of an application, as
opposed to being stored in a database and simply accessed by the application.

Downsides of hard-coding:

* It's way too easy to make a silly mistake and misspell something or just mistype and end up with 500's, especially in a dynamic language like ruby
* it can get pretty confusing: if there's enough of it you can start to forget what the data means, e.g.
  * are we using "draft" here because that's an invoice state or a subscription state or the state of the merchant's LLC application or the kind of beer the merchant is invoicing for?
  * is this 50 I'm seeing all over the code the max number of people that the
    system allows per event, or the number of states in the US?
* because data is ambiguous, it's often unclear when it needs to be changed

Instead of hard-coding data, create or use a constant, or a dedicated class method. There are a lot of benefits to this, e.g.:

* it's more self-documenting: if you name your variables well, there will be no confusion/ambiguity about what the data represents
* a constant/method has much clearer ownership: raw data looks like it can be modified by anyone, whereas something like `Invoices::States::DRAFT` clearly belongs to whatever team owns the Invoices code
* it's way easier to change everything at once: if you ever had to change the invoice state system and rename "draft", it'd be a nightmare having to grep through a big codebase to find all of the hard coded "draft"s and then figure out whether or not the ones you found were for invoice states or something else (again, less ambiguity), whereas if the data is only defined once and then referenced throughout the code with a constant, it only has to be changed once
* if you make a dumb mistake like misspell a class constant or class method your code won't run and/or the typer will yell at you, saving you from 500's
