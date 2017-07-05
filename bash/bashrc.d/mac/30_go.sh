#! /bin/bash

command_exists go || return 0

if command_exists brew ; then
    if [ -f $(brew --prefix)/opt/go ]; then
        PATH=$(brew --prefix)/opt/go/libexec/bin:$PATH
    fi
fi

if [ -d $HOME/go ]; then
    GOPATH=$HOME/go
    PATH=$GOPATH/bin:$PATH
fi
