#! /bin/bash

if [ -d $HOME/.xkb ]; then
    xkbcomp -I$HOME/.xkb $HOME/.xkb/keymap/keyboard $DISPLAY 2>/dev/null
fi
