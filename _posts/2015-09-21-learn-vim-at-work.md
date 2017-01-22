---
title: "Learn Vim at Work"
redirect_from: "/blog/learn-vim-at-work/"
tags: dev-env
excerpt: "Learning vim is daunting. It kills your productivity for at least a full week. So how can anyone justify learning it while at work? This is how I did it."
---

Here's how to learn vim at work without killing your productivity.

### 0. Setup some bare-bones configs
Otherwise vim can be quite unpleasant to use.
   If you're on a Mac and you're like me, then you probably find your CTRL key
to be really inconveniently placed. Since many vim commands include the CTRL
key, map it to something more convenient, e.g. the caps lock key, that you don't
need to look down to hit. This can be
done by going to System Preferences > Keyboard > Modifier Keys.

Next, set up easier escape from insert mode. I recommend mapping `jk` to ESC.
But this is less important, since you can always use `CTRL + c` to exit insert
mode. So if you have a comfortable way to hitting the CTRL key, you're most of
the way there.

### 1. Start using vim on small tasks
I recommend setting your default git editor to be vim
and learning the basic vim commands while writing commit messages.
To do this, start by adding the following to your `~/.gitconfig`:

{% highlight bash %}
[core]
  editor = vim
{% endhighlight %}

Once you have done that, only commit using `git commit`, i.e. without passing the `-m` option, to write your message on the command line.
This is probably good practice to begin with.
It's also something that using an editor like Sublime might lead you to avoid doing.
Who wants to have to open an editor (a relatively slow process) and switch windows just to write a quick message?
And who wants to delete that file afterwards? Waste. of. time.
If you're using vim, this will no longer be an issue.
Now you'll be forced to use vim each time you make a commit -- hopefully
forcing you to use it throughout the course of the day in a low-risk
setting. Commit messages can always be amended!
Fair warning: this will probably be pretty frustrating at first.

### 2. Make a list
Make a list of the useful commands you learn. Here's
[mine](https://gist.github.com/davidlaprade/ec6b0e26a6525f89293a). It's still
growing! By making a list you don't have to worry about memorizing everything.

### 3. Be deliberate
When you are using vim for small tasks like editing commit
   messages and you find yourself doing something the "wrong way"(TM) -- e.g.
deleting a word by first navigating to the end of the word in normal mode, then
entering insert mode, then pressing backspace N times until it's been deleted,
then exiting insert mode -- just stop what you're doing. Undo the changes. And
do it the "right way": `dw`, or whatever. Force yourself to build up muscle
memory using the commands that make vim practical. This is still something I try to do.

### 4. Add some bells and whistles
Once you feel fairly comfortable writing commit messages with vim, you're
   halfway there. At this point I still felt fairly daunted by the prospect of
using vim exclusively. There were just a lot of things that Sublime did well
that vim either didn't seem to do at all or did very poorly.
The most significant of which were (in rough order of importance):

  * fuzzy file finding within the directory
  * grepping within the directory
  * syntax highlighting
  * auto-completion
    * of variable and method names
    * of grouping symbols, e.g. `(`, `[`, `{`, `<p>`
  * copying text to the clipboard
  * multiple cursors
  * multiple windows

So step 3 was just figuring out how to do these things with vim. As it turns
out, it wasn't hard. I just had to use a few plugins, which were easy to
install. Checkout my [vim installation guide](https://github.com/davidlaprade/dotfiles/#vim-installationupdate) for
more details.

### 5. Go cold turkey
Once you have vim configured with all the bells and whistles that other editors have, go cold turkey. Open vim in the root of your directory and start grepping through files.
Open files based on your search results. You'll probably be surprised (like I
was) at how easy it was to go from there!
