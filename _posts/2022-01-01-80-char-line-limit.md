---
title: "Objective Truth: Lines of Code Should Be 80-Characters Long"
tags: dev-env programming
date: "2022-06-26"
excerpt: "An 80 character line limit is objectively superior to whatever barbaric, 3-digit limit you currently have in your linter."
---

I think lines of code should be no more than 80 characters long. Just about
everyone disagrees with me – which is how I know I'm right.

This is my argument:

1. The optimal line length for reading is 45-75 characters.
1. We should optimize code for reading, not writing.
1. On average, code is offset by ~4 chars of whitespace.
1. Hence, we should have at most ~80 character line limits.

This is not just personal preference. It is based on experimentally-verified
features of our psychology, as well as usage patterns in [1.8 trillion lines of
open source code](#the-problem-of-indentation). An 80 character line limit is
objectively superior to whatever barbaric, 3-digit limit you currently have in
your linter.

### The Argument Against 80 Character Lines

These days it's an unpopular<sup>[1](#footnote1)</sup> view that lines of code should be at most 80
characters long. Many see it as an outdated artifact of the days when code was
written on [punch
cards](https://softwareengineering.stackexchange.com/questions/148677/why-is-80-characters-the-standard-limit-for-code-width). No less than the immortal Linus Torvalds [holds this
view](https://lkml.org/lkml/2020/5/29/1038). As he gently puts it:

> Excessive line breaks are BAD. [. . .] [M]any of us have long long [sic] since
skipped the whole "80-column terminal" model. [. . .] Longer lines are
fundamentally useful. My monitor is not only a lot wider than it is tall, my
fonts are universally narrower than they are tall. Long lines are natural. [. .
.] I do not care about somebody with a 80x25 terminal window getting line
wrapping. [. . .] People with restrictive hardware shouldn't make it more
inconvenient for people who have better resources.
[[source](https://lkml.org/lkml/2020/5/29/1038)]

The prevailing argument for abandoning the historic 80-character limit seems to
boil down to this:

1. The only reasons we had for 80-character limits no longer apply.
1. We have big monitors now, and long lines are useful on big monitors.
1. If there are no good reasons to have such a limit, and good reasons to not have it, then we should not have it.
1. Therefore, we should not have an 80-character limit.

Call this "Linus' Argument". It is a
[valid](https://en.wikipedia.org/wiki/Validity_(logic)) argument – if its
premises are true then its conclusion must be true as well – so it should be
taken seriously. But are all of its premises true?

### Against Linus' Argument

No. The first premise is false. There are strong reasons to have 80 characters –
or even fewer – as one's line limit. And they are as strong today as they were
in the days of punch cards.

Against the first premise there are decades of research on the psychology of
reading. And it directly contradicts what Torvalds says about long lines being
"natural". [This
article](https://www.smashingmagazine.com/2014/09/balancing-line-length-font-size-responsive-web-design/) is a very good summary.

> We know that people don't read each individual word. Instead, they use their
foveal (or central) vision to focus on a word, while using their peripheral
vision to find the next spot on which to focus. [. . .] We also know that people
don't fixate on every word, but tend to skip words (their eyes take little
leaps, called "saccades") and fill in the rest. [. . .] [W]e know that readers
anticipate the next line while moving their eyes horizontally along a line; so,
their eyes are drawn down the left edge of the text.
[[source](https://www.smashingmagazine.com/2014/09/balancing-line-length-font-size-responsive-web-design/)]

These properties of our psychology make long lines particularly problematic. If
we read by focusing on every few words and inferring what's in between, there
is a real cost to having long lines which pull our eyes away from the rest of
what we're reading. And if we find the next spot on which to focus using
peripheral vision, we pay a price for long lines that put the next focus point
outside of the periphery.

As the article continues:

> "Reading a long line of type causes fatigue: the reader must move his head at
the end of each line and search for the beginning of the next line." [. . .] If
a casual reader gets tired of reading a long horizontal line, then they're more
likely to skim the left edge of the text [potentially missing important
information at the end of the line]. If an engaged reader gets tired of reading
a long horizontal line, then they're more likely to accidentally read the same
line of text twice (a phenomenon known as "doubling").
[[source](https://www.smashingmagazine.com/2014/09/balancing-line-length-font-size-responsive-web-design/)]

In summary, long lines:

<ol type="A">
  <li>Cause greater fatigue</li>
  <li>Result in more reading errors</li>
  <li>Make it easier to miss important information</li>
  <li>Make it harder to find desired information</li>
  <li>Waste time (via "doubling")</li>
</ol>

The downsides of long lines were famously observed in a pair of eye-scanning
experiments done on Google's search interface<sup>2</sup>. In the experiments,
people were given the Google search results displayed in either its 2005 or 2015
interface and asked to find a specific piece of information.

Here are the resulting heatmaps showing where on the page people looked:

![eye-tracking-heatmaps]({{ site.baseurl }}/jekyll_img/google-eye-tracking-study.png)

(_Image Source: Google Golden Triangle Research: Eye Tracking Study; The
Evolution of Google's Search Results Pages & Effects on User Behavior_)

The people given the 2005 version of the interface initially wasted time reading
the entire lines at the top, then began quickly skimming the left hand column.
In the 2015 version, with a shorter line length, people were able to more
quickly assess whether or not a given result was what they were looking for and
move on if it wasn't.

> The eye tracking demonstrated that people scanned the entire page quickly down
the left side to examine Google's updated categories. [When Google reduced the
line length on their search results] [t]here was significantly less horizontal
scanning compared to the 2005 study. __In fact, the amount of time it took
participants to find a desirable result decreased from the 05's study average
14-seconds to the new study average 8-9 seconds.__
[[source](https://thriveagency.com/news/eye-tracking-study-shows-how-people-view-a-google-search-result/)]

It took people fully ~40% less time to find what they were looking for with
shorter lines. How short? The lines in Google's 2015 interface were
approximately 85 characters long.

I think it's obvious that we want to optimize for each of (A)-(E) above when it
comes to software engineering. We want to make our code as easy as possible to
read correctly. We want engineers to find what they're looking for as quickly as
they can and to avoid unnecessary errors. In all of these respects, long lines
are bad.

So it's simply not true that the "only reasons we had for 80-character limits no
longer apply". As such, the argument is valid but unsound, and its conclusion
doesn't follow.

### The Positive Case for 80-Chars

So far I've made a strictly negative case against "long" lines. But, as the
previous section might suggest, I think we can go further and actually make
a positive argument for 80 character line limits. It goes like this:

1. The optimal line length for reading is 45-75 characters.
1. We should optimize code for reading, not writing.
1. On average, code is prefixed by ~3 chars of whitespace.
1. Hence, we should have at most ~80 character line limits.

If you have doubts about the first premise, spend [2 minutes
googling](https://www.google.com/search?q=optimal+line+length) "optimal line
length". You will quickly find that in Typography – the domain that
actually studies this and performs eye-scanning experiments – the resounding
consensus is 45-75 characters. For instance:

> 65 characters (2.5 times the Roman alphabet) is often referred to as the
> perfect measure. Derived from this number is the ideal range that all
> designers should strive for: __45 to 75__ characters (including spaces and
> punctuation) per line for print.
> [[source](https://www.smashingmagazine.com/2014/09/balancing-line-length-font-size-responsive-web-design/)]

> Anything from __45 to 75__ characters is widely regarded as a satisfactory length
> of line for a single-column page set in a serifed text face in a text size.
> The 66-character line (counting both letters and spaces) is widely regarded as
> ideal. [[source](http://webtypography.net/2.1.2)]

> The length of a line should be comfortable to read: too short and it breaks up
> words or phrases; too long and the reader must search for the beginning of
> each line. If you are uncertain about line length, a good rule of thumb is to
> set the type with __35 to 70__ characters per line.
> [[source](https://photos.google.com/photo/AF1QipNyC261JiJ3tEE1-WKUVlQCpMaAakV78JJQR_b7)]

> The optimal line length for body text is __50–75__ characters
> [[source](https://baymard.com/blog/line-length-readability)]

> [I]t is widely accepted that line lengths fall between __45 and 75__ characters
> per line (cpl), though the ideal is 66 cpl (including letters and spaces).
> [[source](https://en.wikipedia.org/wiki/Line_length)

This should speak for itself.

My reasons for the second premise are straightforward. Code is written once but
read many, many times. We read code far more than we write it. In a long-lived
codebase, for example, code that is written over the course of a couple hours
might be read-only for the next decade. And usually the people who read it are
not the people who write it – meaning we want to make it as easy as possible for
people to discover (rather than remember) its meaning.

### The Problem of Indentation

At this point there is an obvious objection: most code is prefixed by
indentation. And in some languages (e.g. python) indentation actually has a
meaning, so our line limits have to make room for it. Hence, even if it's
psychologically optimal to have short lines, we need to account for the fact
that most code is not going to be able to start at the left edge of the screen.

This cannot be denied. But how much whitespace _on average_ prefixes a line of
code?

The average matters because we shouldn't be purists when it comes to line limits. A line of code
can exceed the limit if there is good reason. What we want is just a rule that
is going to work in the _vast majority_ of cases. With that in mind, it seems that
a reasonable line limit would be equal to the high end of the optimal reading
range – roughly 75 characters – plus the average amount of indentation in the
language.

As it happens, it's possible to get a reasonable approximation of the amount of
indentation in professional codebases for a given language. In 2016, [Github
released](https://github.blog/2016-06-29-making-open-source-data-more-available/) a set of public BigQuery tables to allow people to easily write SQL
against the code in public GitHub repositories.

I wrote a
[query](https://console.cloud.google.com/bigquery?sq=226172199733:c6cfab4e7c6b49e791513d3229f9ddf4)
against this data for the [most popular
languages](https://insights.stackoverflow.com/survey/2021#most-popular-technologies-language)
to find out how much indentation they have on average per
line.<sup>[3](#footnote3)</sup> Here are some of the results:

| Language | Avg Line Length* | Avg Indent. | Indent. (50th%) | Line Length (50th%) | Line Length (99th%) |
| - | - | - | - | - | - |
| sql | 54.8 | 1.2 | 0 | 45 | 204 |
| powershell | 41.8 | 4.5 | 4 | 36 | 156 |
| python | 40.5 | 6.4 | 4 | 37 | 106 |
| scala | 40.3 | 3.7 | 3 | 37 | 117 |
| html | 40.3 | 4.2 | 2 | 28 | 196 |
| c# | 38.6 | 8 | 8 | 32 | 139 |
| java | 37.9 | 4.5 | 4 | 35 | 117 |
| r | 36.7 | 3 | 1 | 31 | 129 |
| swift | 36.6 | 4.6 | 4 | 29 | 150 |
| rust | 35.5 | 5.5 | 4 | 32 | 97 |
| ruby | 35.3 | 4.9 | 4 | 30 | 115 |
| c++ | 35.3 | 3.5 | 2 | 32 | 107 |
| objective c | 34.9 | 1.1 | 1 | 32 | 87 |
| php | 33.4 | 4.3 | 4 | 27 | 128 |
| shell | 32.4 | 1.5 | 0 | 26 | 120 |
| go | 31.4 | 1.2 | 1 | 25 | 114 |
| javascript | 30.8 | 4.8 | 4 | 25 | 109 |
| c | 29.1 | 1.4 | 1 | 26 | 78 |
| css | 24.7 | 1.6 | 1 | 20 | 107 |

\* = _includes indentation_<br>

The query excluded things like binaries, auto-generated files, build-artifacts,
minimized files, data files, non-text files, empty lines, and anything that
didn't look like it was written, or intended to be consumed, by a human.

After all of these filters were applied, the query ran against 1.78 trillion
lines of open source code in the 19 most
popular languages, and found that __there are on average only 4.1 spaces of
indentation per line__ and ~35 characters per line total.

Interestingly, in no case did the average amount of indentation for a language
require that that language have greater than 80 character line limits in order
to accommodate the 45-75 character ideal range prescribed by the psychology of
reading.

Put another way: indentation does not take up all that much space on most lines.
We can use indentation and still comfortably remain within 80 characters
the vast majority of the time.

The query did reveal, however, that an 80-character limit would be disruptive.
Among the most popular languages, only one (C) had a p-99 line length that was
under 80 characters. This means that in most languages, at least 1% of the lines
in open source code are longer than I'm arguing they should be. If any of these
projects were to adopt an 80-character line limit, >1% of the lines would have
to change.

This isn't surprising. Again: _programmers like to write long lines_. It is the
default preference in the age of big monitors. I never said that an 80 character
limit wouldn't have consequences. But I want to emphasize that those
consequences aren't the end of the world.  I have written code in 9 of the 19
most popular languages professionally -- more than that if you include hobby
projects. In every single one of them without exception it has been possible to
write expressive, functional code in under 80 characters per line. Even SQL,
which had far-and-away the highest p99 line length, can be comfortably written
within these limits. As evidence, I submit the [very
query](https://github.com/davidlaprade/davidlaprade.github.io/blob/8135ec83a6d81d1cb7181bebac318bbe74f6ca6c/average-char-per-line.sql) which produced the
data above.

### Objections

__Objection 1.__ *Reading code is just not the same thing as reading prose in a
book or even reading Google search results. It's not a natural language. So
the lessons learned from reading natural language do not apply here.*

Fair. Code is obviously not prose. But there have also been eye scanning studies
done on programmers[<sup>4</sup>](#footnote4) (albeit not as many). And they validate what was said above
-- namely, programmers likewise jump from point to point when they read code,
inferring what's in between, and use their peripheral vision to guide them in
determining where to focus next.

[This](https://dl.acm.org/doi/10.1145/1117309.1117356) is a representative
study, with full text available
[here](https://www.researchgate.net/profile/Roman-Bednarik/publication/220811077_An_eye-tracking_methodology_for_characterizing_program_comprehension_processes/links/0fcfd50aca372c6928000000/An-eye-tracking-methodology-for-characterizing-program-comprehension-processes.pdf?origin=publication_detail) (at the time I am writing). They include one figure of the IDE with a
"representative [eye] scan-path superimposed". Here it is:

![programmer-eye-scanning]({{ site.baseurl }}/jekyll_img/programmer-eye-scan-path.jpg)

Notice how the programmer's eyes jumped around. When reading the code, they
focused on discrete points in the line -- often only one point per line: the
center. This strongly suggests that inference and peripheral version were being
used to fill in the rest of the information: two processes that long lines
disrupt.

It's not surprising that programmers would read code the same way people read
everything else. This is just the way our eyes and brains work. We have a [small nerve
cluster](https://en.wikipedia.org/wiki/Fovea_centralis) in our retina that only
allows us to focus narrowly. With this limitation, the most efficient way to
read _anything_ is to jump from point to point and fill in the
blanks. It's just a consequence of our biology.

__Objection 2.__ *When code is stretched out vertically it's actually difficult to
read/understand.*

I admit it takes some getting used to if you're accustomed to writing code that
can be longer.  But once you are used to it, it actually usually helps in
understanding the code – especially when you're reading code that you did not
write (which, again, is what we should be optimizing for).

Just consider these examples. Which one is easier to understand?

<style>
figure {
  width: fit-content;
}
</style>

{% highlight sql %}
LENGTH(REGEXP_REPLACE(REGEXP_REPLACE(c.content, r'\t', ' '), r'(\n|\r|\v){2,}', '\n')) as cleaned_content,
{% endhighlight %}

VS. the same code broken up so it's under 80 characters per line:

{% highlight sql %}
LENGTH(
  REGEXP_REPLACE(
    REGEXP_REPLACE(c.content, r'\t', ' '),
    r'(\n|\r|\v){2,}',
    '\n'
  )
) as cleaned_content,
{% endhighlight %}

I'll bet the second one was simpler to understand.

What is an input of what
in the first one? You can probably figure it out, but it's emphatically _not_
obvious if you didn't write it. The second one is much more forthcoming about
its meaning.

I think the problem here is that most engineers are optimizing for writing code.
This is completely natural. When you're writing the code, your intent is
perfectly clear to you. But this just isn't the case for anyone reading your
code. We need to be thinking more about the experience of those people.

__Objection 3.__ *Vertical code just wastes space on my screen.*

Then you don't have enough panes open in your editor! Narrow code on a wide
monitor is amazing. You can often have 3 or 4 vertical splits in your editor (in
Vim I sometimes have multiple splits for different parts of the same file),
allowing you to quickly consult other parts of the codebase. It is incredibly
helpful.

### Conclusion

I think that the three premises of my argument are true, and that its conclusion
follows. We should have 80-char line limits even now, in this brave new world of
readily available, wide screen monitors. Even if it is more fun or more
convenient to write code with lines that are longer than 80 characters, the
benefits of shorter lines on reading far outweigh this.

Having such limits does _not_ mean that they should never be exceeded. It just
means that the burden of proof should be on anyone who wants to exceed them. The
linter should yell and we should have to explain ourselves.

There certainly are instances in which exceeding an 80-character limit is
justified. Having 80 character limits just means taking seriously the facts
about our psychology and the languages we use, and then writing code in a way
that optimizes for them.

<br>

---

### Footnotes

<span id="footnote1">[1]</span> Some good examples of the high-quality discussion this topic has seen:
[1](https://stackoverflow.com/questions/110928/is-there-a-valid-reason-for-enforcing-a-maximum-width-of-80-characters-in-a-code),
[2](https://softwareengineering.stackexchange.com/questions/148677/why-is-80-characters-the-standard-limit-for-code-width), [3](https://stackoverflow.com/questions/578059/studies-on-optimal-code-width)

<span id="footnote2">[2]</span>
For more info, see: [1](https://web.archive.org/web/20110407164810/http://eyetools.com/research_google_eyetracking_heatmap.html),
[2](https://web.archive.org/web/20150312014214/https://pages.mediative.com/SERP-Research),
[3](https://www.forbes.com/sites/roberthof/2015/03/03/how-do-you-google-new-eye-tracking-study-reveals-huge-changes/?sh=42a5c8d13828)

<span id="footnote3">[3]</span>
You can view and re-run my query [here
](https://console.cloud.google.com/bigquery?sq=226172199733:882da7fa2e7f4c1ab147e7831aa2b8e9). If you don't already
have one, you will have to create a (free) Google Cloud project to do this.
Running the query costs about $30, which can usually be done
for free with a trial account. If that's too much work, I also put the code in a
[public gist](https://gist.github.com/davidlaprade/cda5775d39c4f6b42b149d1d01111c74),
and saved it to the [repo for this
blog](https://github.com/davidlaprade/davidlaprade.github.io/blob/8135ec83a6d81d1cb7181bebac318bbe74f6ca6c/average-char-per-line.sql).

<span id="footnote4">[4]</span>
Here are some eye tracking studies on programming if you're interested in
reading further:
[1](https://link.springer.com/article/10.1007/s10664-016-9477-x),
[2](https://link.springer.com/article/10.1007/s10664-018-9649-y),
[3](https://dl.acm.org/doi/10.1145/1117309.1117356)

