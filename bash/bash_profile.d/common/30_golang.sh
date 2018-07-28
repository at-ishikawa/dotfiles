#! /bin/bash

if [ "$GOROOT" != "" ]; then
    PATH=$PATH:$GOROOT/bin
fi

if [ "$GOPATH" != "" ]; then
    PATH=$PATH:$GOPATH/bin
fi
