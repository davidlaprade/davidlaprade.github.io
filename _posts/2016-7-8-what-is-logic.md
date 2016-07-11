---
title: "What is Logic"
date: "2016-07-08"
excerpt: "I studied logic. But I'm a software engineer. To help explain the
connection, I here sketch the
history of ideas that led from logic into computation theory."
---

I studied logic. But I'm a software engineer. To understand the connection,
it's helpful to consider the
history of ideas that led from logic into computation theory.

It's useful to begin with a dispute over the nature of arithmetic.
In 1781, the philosopher [Immanuel
Kant](https://en.wikipedia.org/wiki/Immanuel_Kant) published his
_magnum opus_ **The Critique of Pure Reason**, in which he argued that
arithmetical propositions
like `7 + 5 = 12` are not true solely in virtue of their meanings, or concepts:

> [N]o matter how long I analyze my concept of such a possible sum [of
seven and five] I will still not find twelve in it [. . .] One must go beyond
these concepts [of seven and five . . . to] see the number 12 arise.
(Critique, B15)

To see the significance of this claim, contrast a sentence like "All bachelors
are unmarried" with a sentence like "Some flowers are red".
The truth of the first sentence does not depend in any way on the world -- if
a man is unmarried, then he just is a bachelor, that's just what it means --
while the truth of the second does. Kant was claiming, then, that
mathematical claims were more like "Some flowers are red" than "All bachelors
are unmarried". Something else -- something besides the syntax and semantics of
mathematical expressions -- determines whether they are true.

If this is correct, it's very surprising. We tend to think of
math as something we can do just by thinking. But if mathematical sentences are
made true by something more than just their syntax and semantics, how do we have
access to this additional element __just by thinking__?

[Gottlob Frege](https://en.wikipedia.org/wiki/Gottlob_Frege), a German
logician and mathematician, took issue with Kant's claim. He felt that
mathematics was really just logic and set theory in wolves'
clothing. He felt that if we were really clear about what we meant by "5" and
"7", and if we had a logic powerful enough for drawing inferences
about them, then we would see that all of arithmetic simply followed
deductively from set theory. The truth of arithmetic, he thought, doesn't
depend on anything more than its syntax and semantics.

The book that resulted from Frege's attempts to develop a logic strong enough
to prove arithmetic -- the **Begriffsschrift**, published in 1879 -- might be
the single greatest work on logic ever. Frege then published **The Foundations
of Arithmetic** in 1884 to complete his project. There, he attempted to define
the major terms of arithmetic using only set theory and logic:

> [T]he natural numbers 0, 1, 2, 3, etc., considered as sets [. . . can
be] defined in purely logical fashion, namely, for 0 the set of things not
identical with themselves, for 1 the set whose sole member is the number 0, for
2 the set whose members are the numbers 0 and 1, for 3 the set whose members are
the numbers 0, 1, and 2, and so forth.

By the beginning of the 20th century, Frege thinks he's succeeded. But a young
philosopher and logician out of Cambridge named [Bertrand
Russell](https://en.wikipedia.org/wiki/Bertrand_Russell) writes to him in the
summer of 1902:

> [date: 16 June 1902] Dear colleague, For a year and a half I have been
acquainted with your Foundations of Arithmetic, but it is only now that I have
been able to find the time for the thorough study I intended to make of your
work. I find myself in complete agreement with you in all essentials[.] [. . .]
There is just one point where I have encountered a difficulty. You state that a
function, too, can act as the indeterminate element. This I formerly believed,
but now this view seems doubtful to me because of the following contradiction.
Let w be the predicate: to be a predicate that cannot be predicated of itself.
Can w be predicated of itself? From each answer its opposite follows. [. . .]
Very respectfully yours, Bertrand Russell.

Russell discovered a contradiction -- today known as
[Russell's Paradox](https://en.wikipedia.org/wiki/Russell%27s_paradox) -- at
the heart of Frege's system. Frege replied to Russell's letter:

> [date: 22 June 1902] Dear colleague, My thanks for your interesting letter of
16 June. [. . .] Your discovery of the contradiction caused me the greatest
surprise and, I would almost say, consternation, since it has shaken the basis
on which I intended to build arithmetic. [. . .] It is all the more serious
since, with the loss of my Rule V, not only the foundations of my arithmetic,
but also the sole possible foundations of arithmetic, seem to vanish. [. . .] In
any case your discovery is very remarkable and will perhaps result in a great
advance in logic, unwelcome as it may seem at first glance. [. . .] Very
respectfully yours, G. Frege.

Russell and others

kant says: math not true solely in virtue of its syntax/semantics
frege says: math is true solely in virtue of its syntax/semantics
godel says: math not true solely in virtue of its syntax/semantics: not mere
symbol manipulation

    -Russell finds a way to avoid the paradox: his theory of types
  -he and Whitehead publish the monumental Principia Mathematica
-Hilbert
-mathematicians begin dedicating their careers to finding new alternatives to
Pincipia Mathematica
-new problem: how do we know the new system is complete, compact, consistent?
-Hilbert’s marching orders for a theory of mathematics
  - https://en.wikipedia.org/wiki/Hilbert%27s_program
-he wants to show, essentially following Frege, that arithmetic is in some sense
just symbol manipulation
-hilbert succeeds for geometry: a complete axiomatization
  - the terms of geometry are considered "defined in use"
-Godel
    - 1931, incompleteness of arithmetic, single most important result in the history
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
