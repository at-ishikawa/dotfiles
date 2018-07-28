#! /bin/bash

[ "$ANYENV_ROOT" = "" ] && return 0

PATH=$PATH:$ANYENV_ROOT/bin

eval "$(anyenv init - )"
