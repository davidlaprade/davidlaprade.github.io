I studied logic. When I tell people this, they usually don't know what to make
of it. "What is logic?" "Why does logic matter?" These are good questions. This
article is my brief attempt to answer them.

Start with _reasoning_. You _reason_ whenever you use information that you
have to acquire information that you don't. Reasoning is about extracting
information from information, _drawing_ it out. So, for example:
  * given that `x > y` and `y > 2`, we can draw the conclusion that `x > 2`
  * given that it takes an hour to get to Boston driving 65mph, we can draw the
    conclusion that Boston is 65 miles away
  * given that we are in Albany, and Albany is in NY, we can draw the
    conclusion that we are in NY

You get the idea.

Logic is the study of reasoning. It seeks to answer questions like these:
  * what makes good reasoning good, and bad reasoning bad?
  * how can we identify good reasoning and bad reasoning?
  * why should we care if our reasoning is good/bad?
  * what different kinds of reasoning are there?
  * is reasoning fundamentally a mental process, or can it be done by a machine?
  * what are the most common forms of good/bad reasoning?
  * is any form of reasoning objectively good, and any objectively bad?
  * what is the best way to represent the way people reason in English?

That's logic. Why does it matter?

Logic matters because computers matter. I want to make the case here that
computation theory is nothing more than an exceedingly specialized branch of
logic. To do that, I'm going to sketch a cartoon history of logic
and computation theory, showing how advances in the former led directly to
the birth of the latter.

-the systematic study of reasoning begins with Aristotle (birth dates??)
    -Aristotle was a Greek philosopher and scientist
-he developed an extremely influential biology that wasn’t displaced until
Darwin’s Origin of the Species
-when Aristotle died, his students collected his papers and lecture notes
-they found eight works on reasoning, and put them together into a collection
known as the Organon
-perhaps the most influential of said works is the Prior Analytics—probably
written fairly late in Aristotle’s life
-in the Prior Analytics Aristotle draws his fundamental insight: that the
logical form of expressions can be used to study reasoning
-he develops the syllogistic, a system of logic for “all” and “some” statements
-the syllogistic remains the system of logic in use and under investigation for
essentially the next 2000 years
-Aristotle’s logic continued to be sharpened throughout the middle ages, though
it remained largely unchanged
-an interest in the foundations of mathematics in the late 19th century,
however, led to great advances in logic
-Immanuel Kant (1724-1804)
  -extraordinarily influential physicist and philosopher
-he discovered, for example, that the friction from the tidal currents on the
earth’s surface slows the earth’s rotation on its axis
-in 1781, Kant publishes his magnum opus The Critique of Pure Reason
  -there, he makes two important distinctions:
  -analytic/synthetic distinction
    -analytic = true in virtue of meaning
    -synthetic = not analytic
-“all bachelors are unmarried” and “no square has five sides” are analytic
    -“some flowers are red” and “Kant was a physicist” are synthetic
  -apriori/aposteriori distinction
    -apriori = capable of being known without appeal to the senses
    -aposteriori = not apriori
-for example: “2+2=4” is an apriori truth, while “C. albicans is dimorphic” is
an aposteriori truth
-Kant notices that mathematical claims like “5+7=12” seem to be synthetic
apriori claims
-they are not true in virtue of their meanings, like “all bachelors are
unmarried”
-but we do seem to be able to know them without appeal to our senses: empirical
science hasn’t taught us that 5+7=12
-he says: “no matter how long I analyze my concept of such a possible sum [of
seven and five] I will still not find twelve in it [. . .] One must go beyond
these concepts [of seven and five], seeking assistance in the intuition that
corresponds to one of the two, one's five fingers, say [. . .] and one after
another add the units of the five given in the intuition to the concept of seven
[. . .] and thus see the number 12 arise” (Critique, B15)
          -(see SEP on "Kant's Philosophy of Mathematics")
-Frege
  -Frege thinks that arithmetic cannot just be intuition, contra Kant
-if mathematics were just intuition, then arithmetical truths shouldn’t depend
on one another so tightly: we should be able to give one up and see that it
doesn’t affect the others
-for example: 2+2=4, 5-3=2, 10-6=4—if you deny the first but affirm the latter
two, you end up with a contradiction
-additionally, we fail to any intuitions whatsoever about very large
calculations, e.g. 135664+37863=173527.
-[See Kneale and Kneale, The Development of Logic, pp446-447]
    -Frege thinks that arithmetic is in fact analytic
-the idea is that we can define the basic terms of arithmetic in terms of set
theory, then we can use logic to prove all of the arithmetical truths using the
definitions
-but he needs a more advanced logic than Aristotle provides to do derive
arithmetical truths
    -obviously, more than just “all” and “some” statements occur in arithmetic
-luckily for Frege, he was a genius
-the book that resulted from his attempts to develop a logic strong enough to
prove arithmetic--the Begriffshrift, published in ??--might be the single
greatest work on logic ever
-Frege then publishes the Foundations of Arithmetic in YEAR?? To complete his
project
  -here, he attempts to define the major terms of arithmetic using only set
theory and logic
-his definition of the number 0, for example, is the empty set, the number 1 is
then the set that contains 0, the number 2 is then the set that contains 1 and
0, the number 3 is the set that contains 2, 1, and 0, and so on up
-he says: “[T]he natural numbers 0, 1, 2, 3, etc., considered as sets [. . . can
be] defined in purely logical fashion, namely, for 0 the set of things not
identical with themselves, for 1 the set whose sole member is the number 0, for
2 the set whose members are the numbers 0 and 1, for 3 the set whose members are
the numbers 0, 1, and 2, and so forth.”
-[See Kneale and Kneale, The Development of Logic, pp467-468]

      -by the beginning of the 20th century, Frege thinks he's succeeded
-Russell
    -Russell shows that Frege's system is inconsistent
    -Russell's paradox
    -the Frege/Russell correspondence
“[date: 16 June 1902] Dear colleague, For a year and a half I have been
acquainted with your Foundations of Arithmetic, but it is only now that I have
been able to find the time for the thorough study I intended to make of your
work. I find myself in complete agreement with you in all essentials[.] [. . .]
There is just one point where I have encountered a difficulty. You state that a
function, too, can act as the indeterminate element. This I formerly believed,
but now this view seems doubtful to me because of the following contradiction.
Let w be the predicate: to be a predicate that cannot be predicated of itself.
Can w be predicated of itself? From each answer its opposite follows. [. . .]
Very respectfully yours, Bertrand Russell.”
“[date: 22 June 1902] Dear colleague, My thanks for your interesting letter of
16 June. [. . .] Your discovery of the contradiction caused me the greatest
surprise and, I would almost say, consternation, since it has shaken the basis
on which I intended to build arithmetic. [. . .] It is all the more serious
since, with the loss of my Rule V, not only the foundations of my arithmetic,
but also the sole possible foundations of arithmetic, seem to vanish. [. . .] In
any case your discovery is very remarkable and will perhaps result in a great
advance in logic, unwelcome as it may seem at first glance. [. . .] Very
respectfully yours, G. Frege.”
    -Russell finds a way to avoid the paradox: his theory of types
  -he and Whitehead publish the monumental Principia Mathematica
-Hilbert
-mathematicians begin dedicating their careers to finding new alternatives to
Pincipia Mathematica
-new problem: how do we know the new system is complete, compact, consistent?
-Hilbert’s marching orders for a theory of mathematics
-he wants to show, essentially following Frege, that arithmetic is in some sense
just symbol manipulation
-Godel
    -incompleteness of arithmetic, single most important result in the history
of logic
    -there is no finite, consistent set of sentences (axioms) which can prove
every true sentence of arithmetic
    -there is no way to avoid inconsistency/paradox
    -frege's project is doomed
    -mathematics is more than just definitions, more than just symbol
manipulation
-theory of symbol manipulation via Church, Turing, Godel, Kleene, Post
  -if mathematics isn’t just symbol manipulation, what is?
    -use Godel's insights to develop computation theory; leads to development of
modern computers
    -logic thus changed everything
  -if the development of computers is interesting/important, then the
development of logic is interesting/important (since the development of
computers just is the development of logic)
