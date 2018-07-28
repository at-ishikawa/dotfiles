#! /bin/bash

command_exists brew || return 0

if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

brew update 2&>/dev/null &
