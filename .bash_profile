#! /bin/bash

bash_user_dir="$( dirname "${BASH_SOURCE[0]}" )/bash"
source $bash_user_dir/init.sh
source_files $bash_user_dir/bash_profile.d/common/*.sh

if [ `os` ]; then
    source_files $bash_user_dir/bash_profile.d/`os`/*.sh
fi

export PATH
