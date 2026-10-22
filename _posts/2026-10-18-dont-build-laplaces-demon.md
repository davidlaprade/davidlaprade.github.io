---
title: "Don't Build Laplace's Demon"
tags: biology
excerpt: "A bitter lesson of 20th century science tells us that it won't work."
---

Laplace once said:

> An intellect which at a certain moment would know all forces that set nature in motion, and all positions of all items of which nature is composed, if this intellect were also vast enough to submit these data to analysis, it would embrace in a single formula the movements of the greatest bodies of the universe and those of the tiniest atom; for such an intellect nothing would be uncertain and the future just like the past could be present before its eyes.

This “vast intellect” has come to be known as [Laplace’s demon](https://en.wikipedia.org/wiki/Laplace%27s_demon). With its knowledge of the positions and forces of all the atoms in the universe, the demon is able to know every fact there is, from the smallest to the largest, from past to future.

Said another way: Laplace’s demon assumes that if you gave all of the low-level facts about a system to a sufficiently powerful intelligence, all of the high-level facts would fall out.

It seems to me that some significant players in AI biology have the ambition of building Laplace’s demon in this exact sense.

[Here’s Dan Bear](https://youtu.be/uqM8qjbLRHA?si=GTrB7ezJHVXEp1N6\&t=1795), VP of AI Research at [Noetik](https://www.noetik.ai/), describing their patient modeling approach:

> Interviewer: Is there other clinical data that you’re pulling into the model besides the \[. . .] context of the cell, just the surrounding cells? But is there other “this drug caused a bad reaction” kind of stuff?

> Dan Bear: So far we haven’t done much integration of electronic health records or other information that one could get about the patient and that’s pretty intentional. We really want these models to learn basic biology like the central dogma. \[. . .] \[T]he basic biology of genes, proteins, cells, tissue in a self-supervised way, so purely from the data we’re generating, and not be biased by what the doctor wrote about that patient.

Noetik wants to use only the basic, low-level information to predict macro-level facts like, e.g., how patients will respond to cancer therapies. They are trying to build Laplace’s demon for biology.

![noetik-homepage-screenshot]({{ site.baseurl }}/jekyll_img/noetik-homepage-screenshot.png)

I think this is a bad idea.

One of the bitter lessons of 20th century science is that reductionism of the kind Laplace assumed nearly always fails. We've seen it in the inability of mathematics to reduce to logic and set theory (see: [Godel’s incompleteness theorems](https://en.wikipedia.org/wiki/G%C3%B6del%27s_incompleteness_theorems)), of general relativity to reduce to quantum mechanics, of genetic information to reduce to chemistry \[1], and (most controversially) of mind to reduce to neurological or computational systems \[2].

At every significant level of science, reductionism has manifestly failed.

One reason for this is that higher levels often contain “emergent” properties that do not exist at lower levels. For example, no individual electron has superconductivity. Superconductivity arises only when many electrons enter into an ordered state with long-range phase coherence. The resulting properties (zero electrical resistance and magnetic-field expulsion) belong to the superconducting material as a whole, not to any one of its constituents.

Or, to use a biological example, no individual is herd-immune. Herd immunity arises only when a sufficient fraction of a population is immune and chains of transmission break down. The protection it extends to the susceptible few is a property of the population, not of any person within it. But knowing whether a population has heard immunity is vitally important to predicting whether any member will get sick.

(Imagine trying to predict COVID infection and refusing – as a matter of principle – to take high-level information like herd immunity as an input to your model. Good luck!)

This matters for machine learning in scientific domains. Even when low-level data theoretically determines a target, forcing a model to reconstruct every useful higher-level regularity from that data may be computationally wasteful or statistically unrealistic. [It can _sometimes_ be done](https://arxiv.org/pdf/2605.27734). But even when it can, giving the model high- as well as low-level features can make relevant structure easier to learn and more efficient to infer.

And in many important biological tasks, such as predicting treatment response of a tumor, low level data about the patient’s cells is _not_ all that determines the target.

Different levels contain non-overlapping information which a capable model can exploit. For instance:

- A **pathology slide** of a tumor is going to contain cell morphology, tissue architecture, immune-cell infiltration, mitotic activity, necrosis, tumor heterogeneity, spatial organization, etc.
- A **CT scan** is going to contain tumor size and volume, anatomical location, invasion into surrounding tissues, involvement of lymph nodes, distant metastases, vascular encasement, etc.
- A **genetic sequence** is going to contain driver mutations, copy-number alterations, gene fusions, mutational signatures, inherited risk variants, tumor mutational burden, microsatellite instability, etc.
- And a **clinical note** is going to contain demographics, patient history, family history, lifestyle factors, allergies, medications, etc., unique to itself.

All of this information matters if you want to predict the trajectory of a patient’s cancer. All of it helps determine the course of the disease and effectiveness of treatment. If used properly, each modality/level improves prediction.

If this is right, even obvious, why are people still trying to build Laplace’s demon?

I suspect: because adding levels/modalities is not free.

Incorporating more inputs usually means more parameters, greater training cost, harder alignment, noisier data, and a larger risk of learning spurious correlations. Multi-level data is often harder to acquire and more expensive. Some levels may be missing at inference time. Poorly integrated levels can interfere with one another rather than help. A model with five weak or badly aligned inputs may perform worse than a model trained carefully on one strong input. Under a fixed compute budget, spending capacity on an additional modality can also leave less capacity for the rest.

In other words: there are real engineering and scientific challenges. But I believe they can be solved. And, all else being equal, whoever can solve them is going to win.

(_Thanks to Arda P, Zach C, Luis P, Ryan S, and Liam M for helpful feedback on previous drafts of this post._)


<br>

---

### Footnotes

[1] Genetic information is not chemical in nature. It is _information_, information that just happens to have a chemical basis, but which could have been stored in any number of substrates (chemical, photo-electric, magnetic, etc) and with any number of encodings. Witness the [categorical inability of biologists to coherently define the word "gene"](https://plato.stanford.edu/entries/gene/), despite all the scientific, casual, and logical tools currently available to them. There’s a long literature on this.

[2] Over three decades since Chalmers first identified the “hard problem” of consciousness, we are no closer to solving it. No closer to explaining not only how but _why_ any given neurological or computational state gives rise to the mental state that it does. (The most popular response to the problem [remains a denial that it even exists](https://survey2020.philpeople.org/survey/results/5042).)
