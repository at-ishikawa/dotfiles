#! /bin/bash

if [ -d $HOME/local ]; then
    PATH=$HOME/local/bin:$PATH
fi

command_exists brew || return 0

export BREW_INSTALLED_PACKAGES_FILE=$HOME/.homebrew.list

# php7.1
PHP_PATH=$(brew --prefix php@7.1 2>/dev/null)
if [ "$PHP_PATH" != "" ]; then
    PATH=$PHP_PATH:$PATH
fi
