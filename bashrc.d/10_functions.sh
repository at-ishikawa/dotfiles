#! /bin/bash

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
