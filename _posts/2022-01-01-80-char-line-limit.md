---
title: "Objective Truth: Lines of Code Should Be 80-Characters or Less"
tags: dev-env programming
date: "2022-06-26"
---

I think lines of code should be no more than 80 characters long. Just about
everyone disagrees with me – which is how I know I'm right.

This is my argument:

1. The optimal line length for reading is 45-75 characters.
1. We should optimize code for reading, not writing.
1. On average, code is offset by ~3 chars of whitespace.
1. Hence, we should have at most ~80 character line limits.

This is not just personal preference. It is based on experimentally-verified
features of our psychology, as well as usage patterns in 100 billion lines of
open source code. An 80 character line limit is objectively superior to whatever
barbaric, 3-digit limit you currently have in your linter.

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
[query](https://console.cloud.google.com/bigquery?sq=226172199733:882da7fa2e7f4c1ab147e7831aa2b8e9) against this data for the [most popular languages](https://insights.stackoverflow.com/survey/2021#most-popular-technologies-language) to find out how
much indentation they have on average per line.<sup>[3](#footnote3)</sup> Here are the results:

<style>
  table {
    margin-left: -12.5%;
  }
</style>

| language | files analyzed | total indentation | total lines | average indentation (# of spaces) |
|-|-|-|-|-|
| c# | 16080230 | 10185507937 | 1264998505 | 8.05 |
| python | 19496272 | 11840328584 | 1853602169 | 6.39 |
| rust | 768764 | 317469841 | 57331086 | 5.54 |
| swift | 1473737 | 563386192 | 110491522 | 5.1 |
| ruby | 18198326 | 4534757362 | 930740971 | 4.87 |
| javascript | 176731275 | 68978391834 | 14582113863 | 4.73 |
| powershell | 298940 | 109710328 | 23776011 | 4.61 |
| java | 53920248 | 21276014398 | 4810016279 | 4.42 |
| php | 79693227 | 32179723446 | 7535468351 | 4.27 |
| html | 30679746 | 10921580254 | 2561181581 | 4.26 |
| scala | 2114899 | 628289029 | 169943456 | 3.7 |
| c++ | 20139549 | 9060909073 | 2561499977 | 3.54 |
| r | 33134 | 7848197 | 2555276 | 3.07 |
| sql | 1371104 | 131413484 | 66139609 | 1.99 |
| shell | 3966614 | 449667572 | 273164745 | 1.65 |
| css | 30717374 | 5139073564 | 3205581075 | 1.6 |
| c | 172901491 | 49783157808 | 34582967122 | 1.44 |
| go | 23849437 | 3380167180 | 2759290778 | 1.23 |
| objective c | 203463840 | 22297179828 | 20088759145 | 1.11 |
| overall | 855,898,207 | 251,784,575,911 | 97,439,621,521 | 2.58 |

The query excluded things like binaries, auto-generated files, build-artifacts,
minimized files, data files, non-text files, empty lines, and anything that
didn’t look like it was written, or intended to be consumed, by a human.

After all of these filters were applied, the query ran against 855 million open
source software files, covering 97 billion lines of code in 19 of the most
popular languages, and found that __there are on average only 2.5 spaces of
indentation per line (3 if we’re being generous)__.

Interestingly, in no case did the average amount of indentation for a language
require that that language have greater than 80 character line limits in order
to accommodate the 45-75 character ideal range prescribed by the psychology of
reading.

Put another way: indentation doesn’t really matter when it comes to setting line
limits.

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
justified. Having 80 character limits just means taking seriously the facts of our
psychology and the languages we use and writing code in a way that optimizes for
them.

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
](https://console.cloud.google.com/bigquery?sq=226172199733:882da7fa2e7f4c1ab147e7831aa2b8e9). If you don’t already
have one, you will have to create a (free) Google Cloud project to do this.
Running the query costs about $30, which can usually be done
for free with a trial account. If that's too much work, I also put the code in a
[public gist](https://gist.github.com/davidlaprade/cda5775d39c4f6b42b149d1d01111c74).