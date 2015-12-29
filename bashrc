#! /bin/bash

bash_user_dir="$( dirname "${BASH_SOURCE[0]}" )"
source $bash_user_dir/init.sh
source_files $bash_user_dir/bashrc.d/*.sh

if [ "`os`" ]; then
    source_files $bash_user_dir/bashrc.d/`os`/*.sh
fi
