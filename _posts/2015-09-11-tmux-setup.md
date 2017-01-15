---
title: "Tmux Setup with Vim"
tags: dev-env
excerpt: "I recently started using Tmux. Here's how I installed and configured it to play nicely with Vim."
---

Tmux is an incredible tool. It's useful for:

* creating/resizing/moving terminal panes and windows
* executing long-running processes on servers over SSH, then coming back later
  to see how they did
* sharing a terminal sessions with remote team members while paired programming

And it can do all of this on just the home row. Very cool. Unfortunately, it's a little tricky to get Tmux set up with Vim. Here's how I
did it on OSX with iTerm.
Note: some of what follows presupposes that you have configured vim as I have.
For more details, check out my [vim installation instructions](https://github.com/davidlaprade/dotfiles/#vim-installationupdate) in my dotfiles.

### Installation

First the boring part:

{% highlight bash %}
brew update
brew install tmux
brew install reattach-to-user-namespace
# optional -- adds a battery meter to tmux status bar
brew tap Goles/battery && brew install battery
{% endhighlight %}

### Configuration

Now the fun part: customization!

You'll want to create some tmux configuration files. You can view mine
[here](https://github.com/davidlaprade/dotfiles/blob/master/.tmux.conf) and
[here](https://github.com/davidlaprade/dotfiles/blob/master/.tmux.conf.local).
To make things easy, I'll paste the most important bits:


{% highlight bash %}
# put this in ~/.tmux.conf

# make CNTL-s your prefix key
unbind C-b
set -g prefix C-s

# prevent vim coloring from getting messed up
set -g default-terminal 'screen-256color'

# switch between panes like vim with CNTL+h/j/k/l
setw -g mode-keys vi
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R
bind-key -r C-h select-window -t :-
bind-key -r C-l select-window -t :+

# Copy from tmux into OSX clipboard
bind-key -t vi-copy v begin-selection
bind-key -t vi-copy y copy-pipe "reattach-to-user-namespace pbcopy"

# vim-like opening of panes
bind-key - split-window -v -c '#{pane_current_path}'
bind-key / split-window -h -c '#{pane_current_path}'

# resize panes
bind -n S-Left resize-pane -L 2
bind -n S-Right resize-pane -R 2
bind -n S-Down resize-pane -D 1
bind -n S-Up resize-pane -U 1

# Smart pane switching with awareness of vim splits
is_vim='echo "#{pane_current_command}" | grep -iqE
"(^|\/)g?(view|n?vim?)(diff)?$"'
bind -n C-h if-shell "$is_vim" "send-keys C-h" "select-pane -L"
bind -n C-j if-shell "$is_vim" "send-keys C-j" "select-pane -D"
bind -n C-k if-shell "$is_vim" "send-keys C-k" "select-pane -U"
bind -n C-l if-shell "$is_vim" "send-keys C-l" "select-pane -R"
bind -n C-\ if-shell "$is_vim" "send-keys C-\\" "select-pane -l"
{% endhighlight %}

Don't forget to source your tmux config files! From the terminal:
{% highlight bash %}
tmux source-file ~/.tmux.conf
{% endhighlight %}

Finally, you'll need to make sure iTerm's color preferences are correct. Go to
<br/>
`iTerm > Preferences > Profiles > Terminal`
<br/>
and set `Report Terminal Type` to `xterm-256color`.
Otherwise vim's color scheme will get messed up in tmux.

And, last but not least, here are some [tmux commands](https://gist.github.com/davidlaprade/0c54559e9e1007e6aa5b) that I found useful when getting started.


--------------------------

### Thanks to ...

[thoughtbot](https://github.com/thoughtbot/dotfiles) for sharing their awesome `vim` and `tmux` configs!
