#! /bin/bash

if [ -d $HOME/local ]; then
    PATH=$HOME/local/bin:$PATH
fi

command_exists brew || return 0

export BREW_INSTALLED_PACKAGES_FILE=$HOME/.homebrew.list

[ -f $(brew --prefix)/etc/bash_completion ] && . $(brew --prefix)/etc/bash_completion

if [ -f `brew --prefix`/etc/bash_completion.d/git-completion.bash ]; then
  . `brew --prefix`/etc/bash_completion.d/git-completion.bash
fi

if [ -f `brew --prefix`/etc/bash_completion.d/git-prompt.sh ]; then
  . `brew --prefix`/etc/bash_completion.d/git-prompt.sh
  PS1='$(__git_ps1 "git(%s)")$ '
fi

# PHP_PATH=$(brew --prefix php@7.1 2>/dev/null)
# if [ "$PHP_PATH" != "" ]; then
#     PATH=$PHP_PATH/bin:$PATH
# fi
