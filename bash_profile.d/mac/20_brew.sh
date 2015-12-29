#! /bin/bash

if [ -d $HOME/local ]; then
    PATH=$HOME/local/bin:$PATH
fi

command_exists brew || return 0

export BREW_INSTALLED_PACKAGES_FILE=$HOME/.homebrew.list
