---
title: "The Single Responsibility Principle, Part 2"
tags: architecture
excerpt: Software design (AKA architecture) is conceptual analysis, not art.
date: "2017-08-02"
---

_NOTE: this is the second of a two part series on the Single Responsibility
Principle. You can read the first part [here](/blog/the-single-responsibility-principle-part-1)._

The [Single Responsibility
Principle](https://en.wikipedia.org/wiki/Single_responsibility_principle),
or SRP for short,
is a near-universally endorsed principle of software architecture.
It codifies the famous [Unix
maxim](https://en.wikipedia.org/wiki/Unix_philosophy#Origin) that units of
software should
"do one thing and do it well". Put this way, it sounds clear and obvious. But the devil's in
the details.

For example, suppose I ask you what you did this afternoon. You might say that you
did just one thing: you went grocery shopping. But you could also honestly have
said that you did many things:
* you looked through circulars
* you decided what meals to have for the week
* you went through your pantry to find out what foods you had
* you wrote some foods down on a list
* you drove to the market
* you picked up a cart
* you put the foods on your list into your cart
* etc, etc, you get the idea

So which is it? Did you do many things or did you do just one thing? That
depends what level of detail we're supposed to be speaking at. But the point
is that once you start trying to apply this principle, you very quickly realize
that it's anything but clear and obvious.

Did your
afternoon have more than one responsibility? Start poking around and all of a
sudden the SRP

In my previous post on the SRP, I argued that no one has the details of the SRP
quite right. No one has really gotten to the heart of what this principle
consists in.

Try writing code that adheres to this principle and you run into
some difficult problems:
* god methods
* what level does a method have to do one thing at?
* the same event can be described in different ways and seem on some
  descriptions to actually be multiple actions and on others one
*

### Art Not Science

> "I thought of objects being like biological cells and/or individual computers on
  a network, only able to communicate with messages" --Alan Kay, creator of
Smalltalk, on the meaning of "object oriented programming"

a physical object that has been repurposed in another field:
  * tennis balls: tennis, walker pads
  * tonic water: prevent malaria, flavor cocktails
  * teflon: artillery shell fuses, non stick cookware
  * temper foam: NASA space padding, bedding
  * water bath: used in science to keep solutions at temp, used to cook food
    in sous vide
  * pvc pipe: plumbing, stretching
  * duct tape: WWII waterproof tape ("duck tape"), later to repair ducts
  * rubber band: used to hold things together, spin airplane propeller (and
    holds the propeller on?)

evidence of multiple responsibilities:
  * verbose (implementation, method name)
  * logic (in implementation, in method name: "and", "or", "if")
  * use of local variables
  * difficulty unit testing

MAXIM: your method should implement just one thing

There seems to be an unspoken rule: speak at the highest level you can without
inventing words. (Grice on conversational implicature?)

This rule would seem to apply to how we describe the purposes/functions of
software: what a
method does should be described from the highest level that is still correct.


What people call the SRP is really two different principles.
The first principle could justifiably be called the single responsibility
principle: each unit of code should do just one thing. The second might best be called the principle of next level: a method
should be implemented by code at the level directly beneath it, no further.

These principles are distinct because a specification of how to adhere to one would tell you nothing about how to adhere to the other.

The SRP really has its roots in the old Unix maxim of "do one thing and do it well". Cite Bell labs video from Ben here

When I ask you how many things did you do this afternoon, you might say that you
did just one thing: you went grocery shopping. That's one way of putting it.
Another would be that you did many things: you looked
through circulars, you clipped coupons, you decided what meals to have for the
week, you wrote some foods down on a list, you found your car keys, you drove to
the market, you picked up a cart, you put some things in the cart, etc, etc.

There seems to be an unspoken rule: speak at the highest level you can without
inventing words. (Grice on conversational implicature?)

This rule would seem to apply to how we describe the purposes/functions of
software: what a
method does should be described from the highest level that is still correct.

Consider the implementations of two anonymous methods:

# does one thing: charges a credit card
def a
  if verify_credit_card_info(cc_info)
    confirmation_number = capture_credit_card_charge(cc_info)
    payment.confirmation_number = confirmation_number
    payment.save
  end
end

# does two things
def b
  charge_credit_card(cc_info)
  send_confirmation_email(order.user.email)
end

This rule would tell us that method B has multiple responsibilities, but method
A does not. Great!

But the rule does not guard against so-called "God"-methods, e.g.
an application that consisted of a single method that contained all of the logic
and all of the implementation, like this:

{% highlight ruby %}
  def run_the_app(input)
    items = input[0].map{|item_name| Item.find_by_name(item_name)}
    value = items.sum(&:value)
    user_name = input[1].to_s.gsub("_", " ").gsub("\d", "")
    # . . .
    return order_processed ? true : false
  end
{% endhighlight %}

Clearly, this method has more than one responsibility -- in some sense that
software developers care about. But, if we describe its functionality according
to the rule that we should always speak at the highest level, this method
clearly does just one thing: it runs the app. The rule is thus good in only one
direction.  It makes sure everything in an implementation "points up", so to
speak: it ensures that the implementation is "cohesive", with each part
contributing towards and necessary to the main functionality. But it does
nothing to ensure that the method doesn't "point too far down"

Both of these things are a problem!



"How would you describe the responsibility of the Gear class? How about
“Calculate the ratio between two toothed sprockets”? If this is true, the class,
as it currently exists, does too much. Perhaps “Calculate the effect that a gear
has on a bicycle”? Put this way, gear_inches is back on solid ground, but tire
size is still quite shaky."
  - Sandy Metz, POODR, p22

Either way, show how **simply renaming** a method can change the number of
"responsibilities" it has. This shows: the number of responsibilities depends at
least in part on intent, it's not just dependent on the code/implementation
itself.

```

# one responsibility
def rectangle_perimeter(l1, l2, w1, w2)
  lengths = l1 + l2
  widths  = w1 + w2
  lengths + widths
end

# multiple responsibilities
def total_attendees(table1, table2, table3, table4)
  brides_family = table1 + table2
  grooms_family = table3 + table4
  brides_family + grooms_family
end
```

From the interpreter's perspective, these two methods are identical. And yet
we're inclined to the say that the latter, but not the former, has multiple
responsibilities.

Also, the number of responsibilities is dependent on the contexts in
which the code is used -- quite apart from its implementation.

```
# one responsibility, right?
# this method couldn't have a simpler implementation
def coupon_discount
  0.05
end

def calculate_discount
  total * coupon_discount
end

# but now what happens when we add this method?
# now #coupon_discount has a second responsibility: price adjustment
def total
  item_total * (1 + coupon_discount)
end
```

Implementation is simply not the only thing that matters when it comes to
determining whether there is too much code in a method, or class, contra [Sandi
Metz's Rules for
Developers](https://robots.thoughtbot.com/sandi-metz-rules-for-developers).
Even the simplest implementation can have multiple responsibilities. And any
implementation can be changed from having one responsibility to many by simply
using it within a different context.

There's a further problem -- one that Sandi Metz shows off really well in this talk:
https://youtu.be/29MAL8pJImQ?t=18m13s. Even if you keep a method's
usage fixed within an application, you still cannot be sure that the addition of
code won't furnish it with a new responsibility. Consider the following example.

```
class House

  DATA = [ . . . ]

  def data
    DATA
  end

end
```

House#data has one responsibility: it's just a wrapper for some data. The
simplicity of its implementation is evidence of its unity of purpose.  Really,
it couldn't have a simpler implementation.

But now, suppose we add this class:

```
class RandomHouse

  def data
    House::DATA.shuffle
  end

end
```

At once we realize that House#data actually has an implicit responsibility: it's
**sorting** the data it wraps! (Even a null-sort is a sort.)

This points to something important: the meaning of any word can be made
more specific. In this case, "data" can be specified with "sorted data", and
specified further as "sorted filtered data", and still further with "sorted
filtered formatted estimated data", and so on forever. Just add another
past-participle. And if each past-participle reveals another
responsibility, then no piece of code -- no matter how it is named, no matter
what intent we have for it -- is ever truly safe.

The reason why we want the SRP seems to be that it makes code easier to refactor
and change. But what we're seeing now is that adding and removing code changes
the number of responsibilities that any given method has.

At some point, any application that is useable is going to need to expose *some*
high-level interface: "run the app", or whatever. And if the SRP is valuable at
all, it's going to need to say that *some* implementations of "run the app" are
kosher. Otherwise no useable application will ever satisfy the SRP. And if no
useable application can satisfy it, then I think that constitutes a reductio of
the SRP as a principle.

Consider measurement. We can speak at different levels there: ug, mg, g, kg.
1000g constitutes a 1 kg. We can also tell when we're using the wrong level of
measurement. It'd be the wrong level of measurement, e.g., to weigh people using
mg. We can tell this because there'd be extra information in the number that we
just wouldn't care to see given the things we want to do with someone's weight.
How does this transfer? Does it?

One and only one factor seems to determine the number of responsibilities:
* meaning

Meaning is determined, in part, by use.

I think that in order to do the SRP right, you need to be doing some pretty
subtle conceptual analysis of your method and class names.

`#rate` above is ambiguous, or at least unclear. It means both `tax_rate` and
`suggested_tip_rate`. This meaning is determined by its use in the code.

---

Proposal: take a method, attempt to state what it does in the lowest level you
can given only the code in front of you. Then, if you have to use "and" or "or"
in your statement, it has multiple responsibilities, otherwise not.

Example:

```
def order_total
  taxes +
  item_total +
  shipping
end
```

One way to describe what this method does is "calculates the order total". That
seems like a single responsibility. But given what's in the method, can we state
what it does at a lower level? Yes. It "adds the tax amount to the item total
and then the shipping total". This contains "and", hence, we have multiple
responsibilities.

Refactor:

```
def order_subtotals
  [
    taxes,
    item_total,
    shipping,
  ]
end

def order_total
  order_subtotals.inject(&:+)
end
```

It seems like a genuine responsibility has been extracted here. However, we
now have problems stating what `order_subtotals` does without and/or. And it
clearly seems to do one thing. So the proposal needs to be tweaked. But it seems
like a step in the right direction.

---

Are there basic actions -- basic in the sense that they are the acts that
constitute/ground all other acts?

It would seem so. My performing a certain number of steps might constitute my
walking to the park. Some other steps with a few arm movements thrown in might
constitute my doing the Macarena. Some sounds from my vocal chords, a serenade.
My thinking certain things, a prayer. And so on. In each case, the
latter acts are constituted by the former..

The SRP then, could be a demand that the units of our code represent either
basic acts, or composites of them, e.g.

def walk_to_park
  take_step(100)
  ...
end

It's still hard to know just when an act is "basic" in this sense, and perhaps
harder still for the kind of actions we make computers perform -- since they
typically perform what otherwise would be mental actions. But it seems that if
progress could be made in this direction, maybe, just maybe, it could help
illuminate the SRP.

So what are some basic mental acts? Candidates:
* thinking/reasoning/inferring
* remembering
* intending
* desiring
* fearing
* believing
*

The whole notion of "doing one thing" is specious. How are actions individuated?
Are there *fundamental* actions, like there might be fundamental entities?


But not all code is action-oriented. Not all method names are verbs. Sometimes
they are just nouns, e.g. `tax_total`. Grounding here, too? In virtue of what is
some number a tax total of an order?



Let's make this discussion test-driven. Let's start with some famous,
unambiguous cases of multiple-responsibility. Whatever our statement of the SRP
ends up being, then, it should get all of these cases right:
* Sandy Metz' example of the bike #gear method that violates SRP because of data
  structure presupposition




At this point, it's tempting to reach for the "it's an art not a science"
response. It goes like this:

> The SRP isn't perfect. It's just a rough guideline. You're not going
to get anything rigorous -- nor should you expect something rigorous -- because
software engineering is an art. Just as there isn't a rigid formula for what
combinations of paint will look good on a canvas, there isn't a formula for
when you've put too much functionality into a class.

Until recently, I felt that this was the real take-away from the SRP. But now I
think it gives up too fast.

Scientists face the same conceptual problems that software
developers do. Consider the heart. What does it do? On one hand, it seems
that it pumps blood. On the other, it makes a thumping noise. But only the
former constitutes the __function__ of the organ -- __what__
it does, its __purpose__. The thumping is simply a side
effect: part of __how__ it functions.

Notice how similar this is to our problem above? Note the anthopomorphism:
"The __purpose__ of the heart is to pump." As if hearts can think and act
intentionally! Note too the problem of differentiating how from
what: is the thumping part of the __how__ or the __what__? How can we answer
these questions objectively? How can we settle disputes when they arise? The
biologist, in other words, seems to be in a very similar (if not the same)
predicament as the developer.

Should we conclude, then, that biology is an art and not a science?

No, we shouldn't! The biologist's problem can be (and is) solved by
[natural selection](https://en.wikipedia.org/wiki/Natural_selection).
Natural selection in its rough form has three tenets:

1. organisms possess different versions of the same traits
2. different versions of the same trait confer differing fitness levels on
   organisms that have them: i.e. having certain versions of the trait increase
   an organism's propensity to survive and have offspring, while having others
   decrease it
3. traits are heritable, i.e. they are passed down from one generation to
   the next

The function of an organ -- or anything -- in biology is
[__the behavior which accounts for its being selected for__](https://mechanism.ucsd.edu/teaching/w10/wright.functions.%201973.pdf).
The function is _the reason why the organ is there_, it's _raison d'être_. It's
what explains why natural selection favored individuals that had it.

In the case of the heart, its pumping is the reason it's there -- its pumping
explains why having a heart was favored by natural selection. It explains why
(long, long ago) individuals with rudimentary hearts were fitter than individuals
without them. The sounds that the heart makes, alternatively, do not explain why
having a heart was favored. The sounds provide no fitness advantage whatsoever.
Hence, the heart's function is to pump. The pumping, and not the
thumping, is thus the purpose of the heart. It is the sole reason we have a
heart.

Great for the biologists. What does this have to do with software?

I think we miss something important if we don't appreciate the similarities that
digital systems (code-bases) have with living systems (organisms).

> "I thought of objects being like biological cells and/or individual computers on
  a network, only able to communicate with messages" --Alan Kay, creator of
Smalltalk, on the meaning of "object oriented programming"

| organisms | code-bases |
|----------|-------------|
| have generations | have versions |
| generations differ in traits | versions differ in functionality |
| selection by ability to fend off predators, to learn from past mistakes, to acquire food, to compete with others | selection by resilience to hackers, responsiveness to user feedback, availability of company resources, what competitor products did |
| strong selective pressure against useless traits | strong selective pressure against useless functionality |

Hopefully this comparison deepens the feeling that the problem biologists have
solved is the same problem posed by the Single Responsibility Principle.

### What's the Function

My proposal, then, is to understand the SRP in the way biologists understand
biological functions.

> Classes should have a single function


So we can ask of parts of code-bases what we asked of parts of organisms: what
behaviors account for their being selected for? Why didn't we just delete this
class last month? What keeps this around? Why can't I just delete it right now?

Surely this is a question that we can answer.
