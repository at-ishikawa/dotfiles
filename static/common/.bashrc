#! /bin/bash

script_path=${BASH_SOURCE[0]}
bash_user_dir=$(readlink "$script_path")
if [ "$bash_user_dir" = "" ]; then
    bash_user_dir=$script_path
fi
bash_user_dir=$(dirname $(dirname $(dirname $bash_user_dir)))/bash

source $bash_user_dir/init.sh
source_files $bash_user_dir/bashrc.d/common/*.sh

if [ "`os`" ]; then
    source_files $bash_user_dir/bashrc.d/`os`/*.sh
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
