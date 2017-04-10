### Art Not Science

> "I thought of objects being like biological cells and/or individual computers on
  a network, only able to communicate with messages" --Alan Kay, creator of
Smalltalk, on the meaning of "object oriented programming"

**If you could find an example of a physical object that has been famously
repurposed in another field, where it plays two roles, not one, this would
essentially make your whole case**
Ideas:
  * rubber band: used to hold things together, spin airplane propeller (and
    holds the propeller on?)
  * water bath: used in science to keep solutions at temp, used in food to do
    sous vide
  * pvc pipe: plumbing, stretching
  * tennis balls: tennis, walker pads
  * tonic water: prevent malaria, flavor cocktails
  * duct tape: WWII waterproof tape ("duck tape"), later to repair ducts
  * teflon: artillery shell fuses, non stick cookware
  * temper foam: NASA space padding, bedding

Either way, show how **simply renaming** a method can change it from one
responsibility to two. This shows: the number of responsibilities depends at
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

Also show that the number of responsibilities is dependent on the contexts in
which the code is used -- also quite apart from its implementation.

```
# one responsibility, right?
# this method couldn't have a simpler implementation
def rate
  0.05
end

def tax_total(subtotal)
  subtotal * rate
end

# boom! second responsibility
def suggested_tip(total)
  total * rate
end
```

Implementation does not matter when it comes to determining whether there is too
much code in a method, or class, contra [Sandi Metz's Rules for
Developers](https://robots.thoughtbot.com/sandi-metz-rules-for-developers).
Even the simplest implementation can have multiple responsibilities. And any
implementation can be changed from having one responsibility to many by simply
placing it within a method with a different name.

One and only one factor seems to determine the number of responsibilities:
* meaning

Meaning is determined, in part, by use.

I think that in order to do the SRP right, you need to be doing some pretty
subtle conceptual analysis of your method and class names.

`#rate` above is ambiguous, or at least unclear. It means both `tax_rate` and
`suggested_tip_rate`. This meaning is determined by its use in the code.

What does your method name mean? And

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
   organisms that have them: i.e. having certain versions of the trait
   increase an organism's
   propensity to survive and have offspring, while having others
   decrease it
3. traits are heritable, i.e. they are passed down from one generation to
   the next

The function of an organ -- or anything -- in biology is
[__the behavior which accounts for its being selected for__](https://mechanism.ucsd.edu/teaching/w10/wright.functions.%201973.pdf).
The function is _the reason why the organ is there_. It's what explains why
natural selection favored individuals that had it.

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

| organisms | code-bases |
|----------|-------------|
| have generations | have iterations |
| generations differ in traits | iterations differ in functionality |
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
class last month? What keeps this around?

Surely this is a question that we can answer.
