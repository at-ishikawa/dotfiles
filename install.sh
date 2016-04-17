#! /bin/bash

exclude_files=(
    .git
    bash
    README.md
    LICENSE
    lib
    $(basename $0)
)

dotfiles_directory=$(dirname $0)
current_directory=$(pwd)
trap "cd $current_directory" EXIT

cd $dotfiles_directory
dotfiles_directory=`pwd`

for file in $(find $dotfiles_directory -maxdepth 1 -mindepth 1 -execdir echo {} ';')
do
    for exclude_file in ${exclude_files[@]}
    do
        [ "${file}" == "${exclude_file}" ] && continue 2
    done

    ln -sfn $dotfiles_directory/$file $HOME/$file
    echo $HOME/$file
done

# Emacs
which cask >/dev/null
if [ $? -eq 1 ]; then
    cd $dotfiles_directory/.emacs.d
    cask
fi

# Vim
cd $dotfiles_directory/.vim/bundle
[ ! -d neobundle.vim ] && git clone https://github.com/Shougo/neobundle.vim neobundle.vim
