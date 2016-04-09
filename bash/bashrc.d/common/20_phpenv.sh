#! /bin/bash

test -d $HOME/.phpenv || return 0

PATH=$HOME/.rbenv/bin:$HOME/.phpenv/bin:$PATH
eval "$(phpenv init -)"
