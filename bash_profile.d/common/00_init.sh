#! /bin/bash

if [ ! -d $bash_temporary_dir ]; then
    mkdir -p $bash_temporary_dir
fi

if [ -d $HOME/bin ]; then
    PATH=$HOME/bin:$PATH
fi
