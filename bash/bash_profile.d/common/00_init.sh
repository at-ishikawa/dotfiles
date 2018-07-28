#! /bin/bash

if [ ! -d $bash_temporary_dir ]; then
    mkdir -p $bash_temporary_dir
fi

if [ -d $HOME/bin ]; then
    PATH=$HOME/bin:$PATH
fi

export HISTFILE=$bash_temporary_dir/bash_history
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
