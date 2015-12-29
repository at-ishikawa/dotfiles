#! /bin/bash

bash_user_dir="$( dirname "${BASH_SOURCE[0]}" )"
source $bash_user_dir/init.sh
source_files $bash_user_dir/bash_profile.d/*.sh
