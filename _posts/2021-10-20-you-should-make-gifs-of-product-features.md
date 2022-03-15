---
title: How I Make Gifs of Product Features And You Can To
tags: general
excerpt: Making GIFs of your changes and appending them to pull requests is something I find really helpful. This is how I do it.
---

### What

Whenever I make a change to a user-visible part of a project, I try to make a
GIF of the change to include in [my
PR](https://github.com/ScopeLift/umbra-protocol/pull/202). This kind of thing:

![product_gif](https://user-images.githubusercontent.com/7997618/126827894-147f4c9a-5d00-4450-b646-6ab05d52b1c2.gif)

### How

First, record a screencast of the new behavior with Quicktime and save it as a
.mov file.

Then:

{% highlight bash %}
brew install ffmpeg gifsicle
ffmpeg -i screencast_name_here.mov -r 10 -f gif - | gifsicle > feature_change.gif
{% endhighlight %}

### Why

Including GIFs in PRs has a few benefits:

* it makes for easier reviews
  * it gives reviewers
  confidence that the changes actually work and don't introduce bugs
  * it allows
  them to see the changes without deploying to staging or pulling your code
* it's self-documenting
  * rather than reading through a wall of text to figure
  out what change a PR made, you can just see it ~instantly
* it's something most engineers don't do, and it will set you apart
* it's just kind of fun
