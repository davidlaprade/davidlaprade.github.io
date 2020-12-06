---
title: "Software Mentorship Principles"
tags: programming mentorship general
excerpt: "I've had some great mentors and some terrible mentors. I've been a good mentor
and I've probably been a bad mentor. Here are some principles that I've learned
along the way."
---

<style>
  li {
    margin-bottom: 10px;
  }
</style>

I've had some great mentors and some terrible mentors. I've been a good mentor
and I've probably been a bad mentor. Here are some principles that I've learned
along the way:

### Be intellectually humble
  * Take your mentee seriously intellectually. Work hard to understand what
    his/her questions are and give good answers. The same question can have
    multiple meanings (think: ["How do you get to Carnegie Hall?"](https://www.carnegiehall.org/Explore/Articles/2020/04/10/The-Joke)). Don't assume the
    one he/she has in mind is the simple/dumb one.
  * Admit when you're wrong -- you will be.
  * Admit when you don't know things -- there will be times you don't. And don't
    be afraid to redirect your mentee to the person who would know.
  * Tell your mentee when he/she teaches you things. He/she almost certainly
    will. If you've been a mentor before and learned nothing, you were almost
    certainly a bad mentor.
  * Don't use technical words you don't know the meanings of: you're going to look like an
    idiot when you're asked and you can't explain
  * Humility builds trust (more on that below) and
    respect, which will make your praise and feedback much more effective

### Positively reinforce the good things your mentee does
  * [Positive reinforcement](https://en.wikipedia.org/wiki/Reinforcement) is a
    robustly effective tool for making long-lasting changes to the behavior of
    others (i.e. for _teaching_ them). It is a part of our shared lizard brain
  * Praise, _when it's sincere_, and when it's coming from someone that you
    respect/admire, is an incredibly powerful positive reinforcer for just
    about everyone
  * Your mentee _will_ do good things. (Again, if you have had mentees and never
    thought they did anything good, you probably should not be a mentor.) When
    this happens, go out of your way to _tell_ them. E.g. "I really liked how
    you threaded the data
    through this application. That was really complex and you made it look
    simple." Or: "That's an excellent question. I'd never thought of it that
    way. Let me think about it and get back to you."
    Letting your mentee know that you learned something from him/her is
    another great way to do this. "TIL that you can call `reduce` on a Hash!".
  * Do NOT [damn your mentee with faint
    praise](https://en.wikipedia.org/wiki/Damning_with_faint_praise). This
    just makes you seem insincere. If you can only find inconsequential positive
    things to say, e.g. "good job not putting trailing whitespace here", don't say
    anything at all and don't sign up to be a mentor until you can

### Build trust
  * Be honest. Don't say things you don't believe. Don't say something is good
    unless you really mean it. It's almost impossible to maintain a lie over a
    long period of time. Don't even try.
  * Explain yourself. Have good, clear reasons for your requests.
  * Avoid jargon at all costs. When not possible to avoid it, clearly
    explain/define your terms. Using words that another person will not
    understand is at best annoying and at worst self-aggrandizing. Both cut
    against trust.
  * Don't insist on preferences you cannot justify. It makes it seem like either
    you don't know what you're doing, or you're not being honest ("he doesn't
    like my code but won't just say it"). This is very hard, and makes
    mentorship a real challenge that many are not prepared for.
  * Give your mentee chances to try and fail in low-stakes environments. E.g. Let them
    draft a technical design before you weigh in. Let them try to implement
    something their way -- even if they will probably fail.
  * Do NOT take over a project from your mentee ("let me just do it") before
    he/she finishes it. There are few things that more clearly communicate that
    you do not trust him/her to do the work.
  * Without trust, giving constructive feedback is
    basically impossible. Negative feedback from someone you trust is
    constructive: it makes you better. Negative feedback from someone you don't
    is unsettling: it feels like an attack.

### Give explicit constructive feedback
  * Your mentee will need to improve. He/she will do things badly. You need to
    make sure that your mentee's areas of improvement are known to him/her.
  * Phrase criticism in the collective: "I don't think __we__ should hard code
    that data here". "__Let's__ [i.e. let _us_] try to avoid writing our own
    implementation of
    `map` if at all possible." Etc. The point is still clear, but feels less
    personal: you're not going after him/her, just the idea. It's deliberately
    _anti-[ad hominem](https://en.wikipedia.org/wiki/Ad_hominem)_.
  * Rephrase criticism as questions: "Do we definitely still hold the lock at
    this point, or could another process have pre-empted us?" "What if someone
    put `db.collection.drop()` in this input?" "Could we put the default data in
    the Redux store instead of the input component?" Etc. Same as above: this feels
    less personal than something like: "Your idea is terrible and will never
    work."
  * If you have a lot of constructive feedback on a piece of work, write it down
    but deliver the feedback in person. This is incredibly important. A large
    amount of critical feedback can seem _ad hominem_ just because of the
    volume. By delivering
    it in person (i.e. on a call) tone of voice can make it clear that it's not and
    can substantially lessen the chances that it's taken the wrong way.
  * Be _explicit_. Say things like, "I just wanted to give you a little bit of
    feedback..." or "I'd like to see you work on ...". This way there is zero
    confusion/ambiguity that you're attempting to set expectations. Bonus points if
    you keep meeting notes and write it down (just make sure the doc is
    private).
  * Give the feedback in a 1-on-1 conversation, or in the least public way you
    possibly can.
  * Don't rub it in. Only say it if you have to. If your mentee caused an
    incident and got grilled for two hours in an incident review by a dozen
    other engineers, you don't have to bring it up again.
  * Do NOT surprise your mentee on a performance/peer review with
    negative feedback that you have not already told him/her and given him/her a
    chance to work on.

</div>
