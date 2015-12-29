#! /bin/bash

emacs_app=/Applications/Emacs.app
test -d $emacs_app || return 0

alias emacs="open $emacs_app"
alias emacsclient="$emacs_app/Contents/MacOS/bin/emacsclient -c"
