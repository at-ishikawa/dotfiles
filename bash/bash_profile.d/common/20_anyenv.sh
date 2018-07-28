#! /bin/bash

[ "$ANYENV_ROOT" = "" ] && return 0

PATH=$PATH:$ANYENV_ROOT/bin

eval "$(anyenv init - )"

if [ -d $ANYENV_ROOT/envs/ndenv/bin ]; then
    PATH=$PATH:$ANYENV_ROOT/envs/ndenv/bin
    eval "$(ndenv init -)"
fi
