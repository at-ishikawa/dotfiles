#! /bin/bash

exclude_files=(
    .git
    bash
    README.md
    LICENSE
    $(basename $0)
)

dotfiles_directory=$(dirname $0)
current_directory=$(pwd)
trap "cd $current_directory" EXIT

cd $dotfiles_directory
dotfiles_directory=`pwd`

for file in .??*
do
    for exclude_file in ${exclude_files[@]}
    do
        [ "${file}" == "${exclude_file}" ] && continue 2
    done

    ln -sfn $dotfiles_directory/$file $HOME/$file
done
