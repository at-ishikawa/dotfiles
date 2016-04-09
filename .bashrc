#! /bin/bash

bash_user_dir="$( dirname "${BASH_SOURCE[0]}" )/bash"
source $bash_user_dir/init.sh
source_files $bash_user_dir/bashrc.d/common/*.sh

if [ "`os`" ]; then
    source_files $bash_user_dir/bashrc.d/`os`/*.sh
fi
