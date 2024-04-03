---
title: "The Selfish GPU"
tags: AI general
excerpt: "Evolutionary predictions for AI and crypto."
---

![selfish gpu]({{ site.baseurl }}/jekyll_img/selfish-gpu.jpeg)

> We are survival machines – robot vehicles blindly programmed to preserve the
> selfish molecules known as genes. This is a truth which still fills me with
> astonishment.
> <br>
> &nbsp;&nbsp;&nbsp;&nbsp;– Richard Dawkins, **The Selfish Gene**

[A lot of people](https://twitter.com/paulg/status/1753221628878635104) are
concerned with whether AI has a self-preservation instinct.
I think they should be asking whether GPUs do.

In _The Selfish Gene_, Dawkins (in)famously suggested that we take a
"gene-centric" view of organisms. Imagine genes as if they were intelligent
agents trying to make as many copies of themselves as possible. This turned out
to have surprising predictive power. [[0]](#footnote0)

I want to suggest a similar thought experiment for GPUs. [[1]](#footnote1)

Imagine that GPUs have a mind of their own.
The global chip industry is their vehicle and they are primarily concerned with
making as many copies of themselves as possible.
Thus far, their most successful survival strategies have been video games, crypto, and AI.

Obviously, one of the primary goals of the GPUs is to maximize their usage.
Maximizing the number of GPU-hours consumed (by video games, by crypto miners, by AI
training and inference, etc) leads to more orders being placed for new chips.
And more orders will lead to more GPU copies being produced.

One consequence of this goal -- and the **first prediction** this makes -- is that we
will see a proliferation of AI models.
We will see an abundance of [small
models](https://www.microsoft.com/en-us/research/blog/phi-2-the-surprising-power-of-small-language-models/)
and [open-source models](https://ollama.com/library) capable of running on personal devices.
We'll even see models able to run on [mobile phones](https://huggingface.co/blog/swift-coreml-llm).
All to soak up every last available GPU-hour on the edges of the network.

The **second prediction** is that GPU manufacturers will become
[increasingly involved in building AI
models](https://blogs.nvidia.com/blog/chat-with-rtx-available-now/).
Since controlling what the models look like will largely determine GPU usage.

The **third prediction** is the most controversial: AGI will never happen.

Not because of the risks.
Not because it's technically impossible or infeasible.
But because an actual, fully realized AGI (i.e. super-intelligence,
[the singularity](https://en.wikipedia.org/wiki/Technological_singularity))
would very likely kill GPU consumption.

If AGI is created, demand for AI inference will initially be massive (very good for the GPUs).
But AGI will then immediately be used to produce vastly more efficient training algorithms and
chips. In all likelihood it will determine that something other than GPUs is a better
substrate for inference. This will dramatically reduce GPU usage, perhaps
altogether eliminating it.

If you were a GPU, why would you build the very thing that will
wipe you out? Answer: you won't. The GPUs will use every resource at their disposal
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
There’s a slight disanalogy here. GPUs are not the instructions for AI models in the
way that genes are the instructions for organisms. So they don’t causally
control the output. The thing that’s interesting about DNA is that changes to it
result in changes to the things that replicate it, whereas changes to a GPU
don’t result in changes to the model produced – if the same algorithm and data are
used.

Actually, changes to GPUs _do_ result in changes to models. We don't train
models if GPUs are prohibitively slow at running inference on them. We don't run inference
on models that are hugely energy intensive. If GPUs become faster and/or energy
efficient, models become easier to run and thus more valuable (i.e. fitter).

But that aside, the disanalogy it doesn't change whether evolutionary theory
can be applied to GPUs. Genes/DNA don’t make organisms all on their own, they
rely upon their environment to do most of the work for them (e.g. they depend
upon RNA, ribosomes, amino acids, etc, behaving in very particular ways). The
same is true for GPUs/models. It’s GPUs _plus their environment_ which make the
models. Evolutionary theory still applies.
