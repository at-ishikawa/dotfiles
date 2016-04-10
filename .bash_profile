#! /bin/bash

script_path=${BASH_SOURCE[0]}
real_script_path=$(readlink "$script_path")
if [ "$real_script_path" = "" ]; then
    real_script_path=$script_path
fi
script_dir=$(dirname $real_script_path)
bash_user_dir=$script_dir/bash

source $bash_user_dir/.env
source $bash_user_dir/init.sh
source_files $bash_user_dir/bash_profile.d/common/*.sh
if [ `os` ]; then
    source_files $bash_user_dir/bash_profile.d/`os`/*.sh
fi

[ -f $script_dir/.bashrc ] && source $script_dir/.bashrc

export PATH
