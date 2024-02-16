---
title: "The Selfish GPU"
tags: AI general
excerpt: "Evolutionary predictions for AI and crypto."
---


> We are survival machines – robot vehicles blindly programmed to preserve the
> selfish molecules known as genes. This is a truth which still fills me with
> astonishment.
> <br>
> &nbsp;&nbsp;&nbsp;&nbsp;– Richard Dawkins, **The Selfish Gene**

[A lot of people](https://twitter.com/paulg/status/1753221628878635104) are
concerned with whether AI has have a self-preservation instinct.
I think they should be asking whether GPUs do.

In _The Selfish Gene_, Dawkins (in)famously suggested that we take a
"gene-centric" view of organisms. Imagine genes as if they were intelligent
agents trying to make as many copies of themselves as possible. This turned out
to have surprising predictive power. [[0]](#footnote0)

I want to suggest a similar thought experiment for GPUs. [[1]](#footnote1)

Imagine that GPUs have a mind of their own. The global chip industry is their
vehicle and they are primarily concerned with
making as many copies of themselves as possible. What does the future look like?

I think there are at least two contrarian predictions that fall out of this
– one for each of the ingenious survival strategies GPUs have devised for
themselves: crypto and AI.

The first prediction is that crypto will evolve so as to maximize global hash
rates, even while [popular protocols](https://ethmerge.com/) switch from proof
of work (which requires GPUs) to proof of stake (which does not). Protocols may
continue to fork off of proof of work, but [global hash
rates](https://www.blockchain.com/explorer/charts/hash-rate) (i.e. GPU usage)
will not decline.  New networks will spring up or existing networks will switch
over to absorb the work that others leave behind. The GPUs will stay hot

The second and perhaps more interesting prediction is that AI will develop so as
to maximize GPU usage over intelligence.

AI models will proliferate. We will see an abundance of [small
models](https://www.microsoft.com/en-us/research/blog/phi-2-the-surprising-power-of-small-language-models/)
capable of running on [personal
devices](https://huggingface.co/blog/swift-coreml-llm), to soak up every last
GPU-hour on the edges of the network. GPU manufacturers will become
[increasingly involved in building AI
models](https://blogs.nvidia.com/blog/chat-with-rtx-available-now/), since
(again) they want to maximize GPU usage, and controlling what the models look
like will largely determine that.

Also, by the way, AGI will never happen. Not because of the risks. Not because
it's impossible. But because an actual, fully realized AGI would kill GPU
consumption. It would make training new models largely (if not entirely)
unnecessary. If you were a GPU, why would you build the very thing that will
wipe you out? Nope, no way. The GPUs will use every resource at their disposal
to prevent this from happening. And their resources are considerable.

As silly as this thought experiment may seem, evolutionary
forces do bear on GPUs and the industry surrounding them. Evolution
applies equally to all replicators — i.e. anything that is copied. And
many, many copies of GPUs are made each day. We neglect this at our peril.

(_Thanks to Matt Dupree for feedback on earlier drafts of this post._)

<br>

---

### Footnotes


<span id="footnote0">[0]</span>
In particular, it gave us a ready explanation for otherwise perplexing
altruistic behavior. Why would an organism willingly give up its life to protect
others? Nothing is more deeply opposed to an organism's fitness than self
sacrifice. But when you take into account that (a) creatures are most likely to
sacrifice themselves for their children, and (b) children share some of the same
genes as parents, it starts to look a lot more explicable on the gene-centric
level.

<span id="footnote1">[1]</span>
Couldn't you apply the same reasoning to any physical product? "It's copied.
Therefore, it's a replicator. Therefore, it will evolve so as to maximize its
replication." Yes, you can. Except that not all products live on. The
environment kills most of them. So, yes, products *that live on* will continue
to evolve in ways that maximize their replication.  The GPU is a product
exceedingly likely to live on.

<span id="footnote2">[2]</span>
I remember a [great blog
post](https://www.buildblockchain.tech/blog/pow-window-closed) which
argued that the window for starting a new
proof of work chain was over. Counterexample: miners from a network that
abandons PoW start their own PoW network with the same consensus mechanism.

