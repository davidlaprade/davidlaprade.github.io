---
title: "How to not use a Mouse on OSX"
excerpt: "Using a mouse is almost always an avoidable waste of time. Here's how I largely get by without one on OSX"
---

## Description
This is a list of OSX hotkeys for common apps. They can be used in place of
many mouse/trackpad operations to speed up workflows.

### General OSX
* `CMD + c` = copy
* `CMD + v` = paste
* `CMD + V` = paste without formatting
* `CMD + x` = cut
* `CMD + z` = undo
* `CMD + y` = redo
* `CMD + a` = select all
* `CMD + p` = print
* `CMD + s` = save
* `CMD + q` = quit application
* `CMD + w` = close current application window
* `CMD + Tab` = switch to last application
* `CMD(hold) + Tab` = view open applications, while still holding `CMD` you can:
  * `Tab` = select next running application
  * `left-arrow/right-arrow` = select previous/next running application
  * `q` = quit selected application
  * `n` = open a new window for the selected application
  * (release `CMD` key) = switch to selected application
* `CMD + space` = open searchlight
When in a text-editing context:
* `OPT + delete` = delete previous word
* `CMD + delete` = delete to beginning of line
* `CMD + Shift + arrow-left/arrow-right` - select to beginning/end of line
* `CMD + Shift + arrow-up/arrow-down` - select to top/bottom of document
* `OPT + Shift + arrow-left/arrow-right` - select previous/next word
* `CMD + left-arrow` = move cursor to start of line
* `CMD + right-arrow` = move cursor to end of line
* `CMD + top-arrow` = move cursor to top of document
* `CMD + bottom-arrow` = move cursor to bottom of document
* `OPT + left-arrow` = move cursor to start of current word
* `OPT + right-arrow` = move cursor to end of current word
* `FN + delete` = forward delete
* `SHIFT + up/down` = select up/down one line

### Chrome
* `CMD + t` = open a new tab
* `CMD + l` = highlight URL of current page
* `CMD + OPT + arrow-left/arrow-right` = move to previous/next tab
* `CMD + w` = close tab
* `CMD + r` = refresh tab
* `CMD + R` = hard refresh tab
* `CMD + l + (keep holding CMD) + ENTER` = duplicate current tab
* `CMD + left/right arrow` = go to previous/next in history
* type search string into address bar to run google search
  * use `Tab` to move to next auto-completed suggestion
  * use `Tab` to move cursor to next search option, enter to select
* `CMD + 9` = jump to last tab
* `CMD + (1-8)` = jump to n-th tab
* `CMD + C` = view DOM, dev tools
Requires 3rd-party applications:
* `CMD + \` = open 1password

### Gmail
* `gi` = navigate to inbox
* `c` = compose email (must be in inbox)
Once you are in compose mode:
  * `Tab` = move between to/from, subject, and body fields
  * `CMD + ENTER` = send email
* `j` = move cursor down (to previous email)
* `k` = move cursor up (to next email)
* `x` = select current email
* `* + u` = select all unread emails
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
Work even with Tmux
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
* `CMD + d` = split screen vertically
* `CMD + SHIFT + d` = split screen horizontally
* `CMD + w` = close terminal window
* `CMD + OPT + arrow key` = move between terminal windows
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

### Slack
* `CMD + k` = search for and jump to conversation

### Sublime
* `CMD + n` = open a new tab
* `CMD + OPT + arrow key` = move to tab
* `CMD + w` = close tab
* `SHIFT + up/down arrow` = highlight line above/below
* `CMD + left/right/up/down` = jump to start/end of line or top/bottom of the
  doc
* `CMD + SHIFT + left/right arrow` = highlight to end of line
* `CMD + SHIFT + L` = open cursor on each highlighted line
* `CMD + CTRL + G` = open cursor at each instance of highlighted text
* `CMD + D` = open cursor at next instance of highlighted text
* `CMD + P` = find file by name
* `CMD + SHIFT + F` = grep for string through entire directory
* `CMD + R` = jump to symbol on current page
