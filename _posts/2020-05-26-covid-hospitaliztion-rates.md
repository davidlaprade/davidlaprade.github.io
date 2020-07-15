---
title: COVID-19 Hospitalization Rates
tags: general
excerpt: "The odds of having a severe case, broken down by age group."
---

_DISCLAIMER: I am not a doctor and this is not medical advice._

### Results

Here is the calculated likelihood of having a severe infection (requiring
hospitalization) if you contract
[SARS-CoV-2](https://en.wikipedia.org/wiki/Severe_acute_respiratory_syndrome_coronavirus_2):

| Age | Hospitalization<br>Rate (Overall) | Hospitalization Rate<br>(No Pre-Existing Conditions) |
|--|--|--|
| 0-17     | 0.13%  | 0.01% |
| 18-44    | 1.17%  | 0.07% |
| 45-64    | 4.24%  | 0.26% |
| 65-74    | 8.22%  | 0.50% |
| 75+      | 13.05% |  0.80% |
| Overall  | 3.07%  | 0.19% |

In other words: a healthy 18-44yo has a 0.07% chance of being hospitalized if
he/she gets the virus. That's a 1 in 1400 chance.

To put that number in perspective, you are ten times more likely to be [audited
by the
IRS](https://www.nolo.com/legal-encyclopedia/what-are-the-odds-being-audited.html)
(0.6% chance) than to need hospitalization for COVID-19. Having a severe
reaction to COVID as a healthy young person is about as likely as getting
[selected to be an
astronaut](https://www.latimes.com/science/sciencenow/la-sci-sn-nasa-astronaut-candidates-20170607-htmlstory.html)
(1 in 1500).

### Methods

Start with some obvious claims:

>  (1)  % hospitalized in age group = hospitalizations due to infection / number of infections

>  (2)  number of infections = population * infection rate

Putting these together, we get:

>  (3)  % hospitalized in age group = hospitalizations due to infection / (population * infection rate)

But NYC hasn't published total hospitalizations by age group. They only publish
[hospitalization rate _per 100k
people_](https://www1.nyc.gov/site/doh/covid/covid-19-data.page)
per age group. That's much less useful.
Fortunately, though, we can use that to get what we want without much
difficulty. After all:

>  (4)  hospitalizations = (hospitalizations per 100k * 1/100k * population)

Substituting this in (3) we get:

>  (5)  % hospitalized in age group = (hospitalizations per 100k * 1/100k * population) / (population * infection rate)

Which immediately allows us to cancel out _population_:

>  (6)  % hospitalized in age group = (hospitalizations per 100k * 1/100k) / infection rate

That leaves just infection rate, which we can estimate from the antibody
tests that were done on 15k random NY residents. The breakdown by region can be seen
[here](https://www.governor.ny.gov/news/amid-ongoing-covid-19-pandemic-governor-cuomo-announces-results-completed-antibody-testing), but the result was that 19.9% of NYC residents
tested had antibodies for the virus. The presence of antibodies is [very
strong evidence](https://pubmed.ncbi.nlm.nih.gov/32350462/) that these people had
COVID-19. And, given that the sample was random, we can reasonably extrapolate
that 19.9% of the NYC population at large had the virus by the time of the study.

Plugging this infection rate into formula (6) we obtain:

>  (7)  % hospitalized in age group = (hospitalizations per 100k * 1/100k) / 19.9%

But that just gives us the _overall_ infection rate for a given age group. It
does not differentiate between those who were healthy and those who had
underlying conditions. This is significant because an overwhelming number
([93.9%](https://time.com/5825485/coronavirus-risk-factors/)) of
people hospitalized for COVID-19 had pre-existing conditions in NYC, most commonly
[diabetes, hypertension, and/or
obesity](https://jamanetwork.com/journals/jama/fullarticle/2765184?guestAccessKey=906e474e-0b94-4e0e-8eaa-606ddf0224f5). This means that only 6.1% of hospitalized patients were
healthy at the time of infection.

With this, we can easily refine our formula to give us the rate at which healthy people
are hospitalized with COVID-19. First note that:

>  (8)  healthy hospitalization rate for age group = % healthy in hospital x % hospitalized in age group

Combining this with (7) we get:

>  (9)  healthy hospitalization rate for age group = % healthy in hospital x (hospitalizations per 100k * 1/100k) / 19.9%

Since we know that 1 - 93.9% = 6.1% of hospitalized COVID patients did not have
underlying conditions, we get:

>  (10)  healthy hospitalization rate for age group = 6.1% x (hospitalizations per 100k * 1/100k) / 19.9%

Using (10) and the
[hospitalization rates per 100k
people](https://www1.nyc.gov/site/doh/covid/covid-19-data.page)
per age group published by NYC, we get the following results:

| Age | Hospitalizations (per 100k) | Overall Infection Hospitalization Rate | Healthy Infection Hospitalization Rate |
|--|--|--|--|
| 0-17     | 26.46   | 0.13%  | 0.01% |
| 18-44    | 232.63  | 1.17%  | 0.07% |
| 45-64    | 844.19  | 4.24%  | 0.26% |
| 65-74    | 1635.06 | 8.22%  | 0.50% |
| 75+      | 2596.28 | 13.05% |  0.80% |
| Overall  | 610.65  | 3.07%  | 0.19% |

### Objections

__1. But the infection rate near me hasn't been nearly as high as it was in NYC__

That's great! But it doesn't matter to the calculations. If the virus puts 1 in
1400 infected healthy people in the hospital in NYC, it should do the same in
Timbuktu, even if Timbuktu only has 5 infected healthy people.

Put another way: the calculation doesn't consider your odds of getting the
virus -- only your odds of being hospitalized if you do get the virus.

__2. It seems wrong to apply the 93.9% rate of hospitalization
   uniformly across age groups. Very likely that rate was
   different for each age group.__

I'm sure there were differences between the age groups, but the paper doesn't
list them. I have requested the information from the corresponding author of the
study. But I doubt they were significantly different from the 93.9% overall
figure. Think about it: if the virus were disproportionately affecting healthy people in
a given age group that would be exceptionally interesting and the authors
almost certainly would have noted it. But they didn't note anything like it.
Hence, I think it's safe to assume the data were comparable.

In either case, there is an upper bound to the error here. 350 of the 5700 hospitalized
patients in [the
study](https://jamanetwork.com/journals/jama/fullarticle/2765184?guestAccessKey=906e474e-0b94-4e0e-8eaa-606ddf0224f5
) had no comorbidities (see table 1). Now, for example, there were 660
patients between 20-49 yo in the study (see table 4). So, even if we assume that
_all_ patients without underlying symptoms were in the 20-49 yo range, we still
end up with 53% of patients admitted in the 20-49 yo range had no underlying
symptoms. So you still end up with 1 in 700 odds of hospitalization for healthy
individuals in that age range.

__3. But I thought anitbody tests had high false positive rates__

That's true for all I know -- though I've not seen any studies backing this up. I've seen [some
sources](https://www.forbes.com/sites/tommybeer/2020/05/26/cdc-says-possibly-less-than-half-of-positive-antibody-tests-are-correct/#5340a7df2391)
claiming that as many as 50% of positives are false. So, again, if this concerns
you, you can conservatively cut the numbers in half.
