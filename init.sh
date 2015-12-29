#! /bin/bash

bash_temporary_dir=$bash_user_dir/tmp

function source_files() {
    for file in `ls $@`; do
        source $file
    done
}

function os() {
    uname_path=`which uname`
    if [ "$uname_path" != "" ]; then
        if [ `$uname_path` = "Darwin" ]; then
            echo "mac"
        elif [ `$uname_path` = "Linux" ]; then
            echo "linux"
        fi
    fi
}
