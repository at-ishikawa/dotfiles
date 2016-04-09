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

function command_exists() {
    type "$1" >/dev/null 2>&1
}

function join() {
    tmp=$IFS
    separator="$1"
    array=("$@")
    IFS="$separator"
    echo "${array[*]:1}"
    IFS=$tmp
}
