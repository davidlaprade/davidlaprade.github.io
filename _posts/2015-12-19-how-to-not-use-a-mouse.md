---
title: "How to not use a Mouse on OSX"
excerpt: "Using a mouse is almost always an avoidable waste of time. Here's how I get by without one."
---

This is a list of OSX hotkeys for common apps. They can be used in place of
many mouse/trackpad operations to speed up workflows.

Here's an example of the kind of thing you can do...

### Example
Here's how I would send someone a link to a line in my dotfiles on slack.

* Is Chrome open?
  * No
    * <code>&#8984; + space</code> to open spotlight
    * Start typing `chrome` until spotlight finds Chrome (this usually only
      requires me to type `c`) then hit Enter to open Chrome
  * Yes
    * <code>&#8984; + Tab</code> to open a list of running applications
    * hold <code>&#8984;</code> then hit `Tab` until you get to Chrome
* Does Chrome have an open window?
  * No - <code>&#8984; + n </code> to open a new window
  * Yes - skip this step
* Are you in a new tab?
  * No - <code>&#8984; + t</code> to open a new one
  * Yes - skip this step
* <code>&#8984; + l</code> to highlight whatever is in the address bar
* type `git dav dot` in the search bar; Chrome will look through my history for
  a URL that matches each of these strings. When I see the URL I want in the
  suggestions, I hit `Tab` to get to it and then `Enter` to go to it. I'm now in
  the github repo.
* `t` to enter search mode in the github repo
* start typing `alias` into the search until `.aliases` is the first choice (usually
only takes `al`) then press `Enter`
* `y` to switch the URL to reference the SHA of file's current commit
* `l26` to highlight the line I want to send, line 26
* <code>&#8984; + l</code> to highlight the current URL
* <code>&#8984; + c</code> to copy the URL
* Is Slack open?
  * No
    * <code>&#8984; + space</code> to open spotlight
    * Start typing `slack` until spotlight finds Slack (this usually only
      requires me to type `sl`) then hit Enter to open Slack
  * Yes
    * <code>&#8984; + Tab</code> to open a list of running applications
    * hold <code>&#8984;</code> then hit `Tab` until you get to Slack
* <code>&#8984; + k</code> then type in the first few letters of the person I
  want to send the message to, then hit `Enter`
* <code>&#8984; + v</code> to paste the URL, then `Enter` to send

Boom. No mouse clicks!

### General OSX
* <code>&#8984; + c</code> = copy
* <code>&#8984; + v</code> = paste
* <code>&#8984; + V</code> = paste without formatting
* <code>&#8984; + x</code> = cut
* <code>&#8984; + b</code> = bold selected text
* <code>&#8984; + i</code> = italicize selected text
* <code>&#8984; + u</code> = underline selected text
* <code>&#8984; + z</code> = undo
* <code>&#8984; + y</code> = redo
* <code>&#8984; + m</code> = minimize current window
* <code>&#8984; + n</code> = open new window
* <code>&#8984; + f</code> = find text
* <code>&#8984; + a</code> = select all
* <code>&#8984; + p</code> = print
* <code>&#8984; + s</code> = save
* <code>&#8984; + q</code> = quit application
* <code>&#8984; + w</code> = close current application window
* <code>&#8984; + Tab</code> = switch to last application
* <code>&#8984;(hold) + Tab</code> = view open applications, while still holding <code>&#8984;</code>:
  * `Tab` = select next running application
  * <code>&#8592;/&#8594;</code> = select previous/next running application
  * `q` = quit selected application
  * `n` = open a new window for the selected application
  * (release <code>&#8984;</code> key) = switch to selected application
* <code>&#8984; + space</code> = open searchlight

When in a text-editing context:

* `OPT + delete` = delete previous word
* <code>&#8984; + delete</code> = delete to beginning of line
* <code> &#8984; + Shift + &#8592;/&#8594;</code> - select to beginning/end of line
* <code> &#8984; + Shift + &#8593;/&#8595;</code> - select to top/bottom of document
* <code> OPT + Shift + &#8592;/&#8594;</code> - select previous/next word
* <code> &#8984; + &#8592;</code> = move cursor to start of line
* <code> &#8984; + &#8594;</code> = move cursor to end of line
* <code> &#8984; + &#8593;</code> = move cursor to top of document
* <code> &#8984; + &#8595;</code> = move cursor to bottom of document
* <code> OPT + &#8592;</code> = move cursor to start of current word
* <code> OPT + &#8594;</code> = move cursor to end of current word
* `FN + delete` = forward delete
* <code>SHIFT + &#8593;/&#8595;</code> = select up/down one line

### Chrome
* <code>&#8984; + f</code> = find text
* <code>&#8984; + t</code> = open a new tab
* <code>&#8984; + l</code> = highlight URL of current page
* <code>&#8984; + OPT + &#8592;/&#8594;</code> = move to previous/next tab
* <code>&#8984; + w</code> = close tab
* <code>&#8984; + r</code> = refresh tab
* <code>&#8984; + R</code> = hard refresh tab
* <code>&#8984; + -/+</code> = zoom out/in
* <code>&#8984;(hold) + l + ENTER</code> = duplicate current tab
* <code>&#8984; + &#8592;/&#8594;</code> = go to previous/next in history
* <code>&#8984; + 9</code> = jump to last tab
* <code>&#8984; + (1-8)</code> = jump to n-th tab
* <code>&#8984; + C</code> = view DOM, dev tools
* type search string into address bar to run google search
  * use `Tab` to move to next auto-completed suggestion
  * use `Tab` to move cursor to next search option, enter to select

Requires 3rd-party applications:

* <code>&#8984; + \</code> = open 1password

### Gmail
* `gi` = navigate to inbox
* `j` = move cursor down (to previous email)
* `k` = move cursor up (to next email)
* `x` = select current email
* `* + u` = select all unread emails
* `c` = enter compose mode (must be in inbox)

Once you are in compose mode:

  * `Tab` = move between to/from, subject, and body fields
  * <code>&#8984; + ENTER</code> = send email

Once one or more emails have been selected you can:

  * `I` = mark as read
  * `* + n` = deselect all
  * `ENTER` = view selected email

Once you are in view mode for a given email you can:

  * `r` = reply to email
  * `a` = reply all to email
  * `f` = forward email

### iTerm
__I highly recommend mapping your Caps Lock key to CNTL__

The following hotkeys work even with Tmux

* `CNTL + a` = jump to start of line
* `CNTL + e` = jump to end of line
* `CNTL + u` = delete to beginning of line
* `CNTL + c` = delete entire line
* `CNTL + r` = search for previous commands containing search string
* `CNTL + p` = repeat last command
* `CNTL + b` = go back a character
* `CNTL + d` = delete forward
* `CNTL + w` = delete back to previous space
* `CNTL + f` = go forward a character

Won't work in Tmux session

* <code>&#8984; + d</code> = split screen vertically
* <code>&#8984; + SHIFT + d</code> = split screen horizontally
* <code>&#8984; + w</code> = close terminal window
* <code>&#8984; + OPT + arrow key</code> = move between terminal windows
* `CTRL + k` = delete to end of line (I mapped this to move to lower tmux pane)

### Github
* `t` = search repository by file name
  * `ESC` = exits search mode
* `w` = search repository by branch name
* `?` = open list of hotkeys
* `gi` = jump to issues
  * `c` = create issue (when on issues page)
* `gc` = jump to code
* `gp` = jump to pull requests

When viewing a code file:

* `y` = change URL to reference the specific commit SHA of the code you're
  looking at
* `l` = go to line

### Slack
* `CMD + k` = search for and jump to conversation

### Sublime
* <code>&#8984; + n</code> = open a new tab
* <code>&#8984; + OPT + arrow key</code> = move to tab
* <code>&#8984; + w</code> = close tab
* <code>SHIFT + &#8593;/&#8595;</code> = highlight line above/below
* <code>&#8984; + &#8592;/&#8594;/&#8593;/&#8595;</code> = jump to start/end of line or top/bottom of the
  doc
* <code>&#8984; + SHIFT + &#8592;/&#8594;</code> = highlight to beginning/end of line
* <code>&#8984; + SHIFT + L</code> = open cursor on each highlighted line
* <code>&#8984; + CTRL + G</code> = open cursor at each instance of highlighted text
* <code>&#8984; + D</code> = open cursor at next instance of highlighted text
* <code>&#8984; + P</code> = find file by name
* <code>&#8984; + SHIFT + F</code> = grep for string through entire directory
* <code>&#8984; + R</code> = jump to symbol on current page
