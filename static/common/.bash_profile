#! /bin/bash

script_path=${BASH_SOURCE[0]}
real_script_path=$(readlink "$script_path")
if [ "$real_script_path" = "" ]; then
    real_script_path=$script_path
fi
script_dir=$(dirname $real_script_path)
bash_user_dir=$(dirname $(dirname $script_dir))/bash

if [ -f $bash_user_dir/.env ]; then
    source $bash_user_dir/.env
else
    echo -e "\033[31m$bash_user_dir/.env not found\033[0m" >&2
    return
fi
source $bash_user_dir/init.sh
source_files $bash_user_dir/bash_profile.d/common/*.sh
if [ `os` ]; then
    source_files $bash_user_dir/bash_profile.d/`os`/*.sh
fi

[ -f $script_dir/.bashrc ] && source $script_dir/.bashrc

export PATH

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

