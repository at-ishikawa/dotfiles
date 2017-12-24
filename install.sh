#! /bin/bash

current_directory=$(pwd)
trap "cd $current_directory" EXIT

function linkFiles()
{
    source_directory=$1
    for file in $(find $source_directory -maxdepth 1 -mindepth 1 | awk -F/ '{ print $NF }')
    do
	ln -sfn $source_directory/$file $HOME/$file

	is_symbolic_link_failed=$(find $HOME/$file -xtype l)
	if [ "$is_symbolic_link_failed" ]; then
	    echo -e "\033[31m"$HOME/$file "\033[00m is broken symbolic link." >&2
	else
	    echo $HOME/$file
	fi
    done
}

dotfiles_directory=$(dirname $0)
cd $dotfiles_directory
dotfiles_directory=$(pwd)

. bash/init.sh
linkFiles $dotfiles_directory/common
os=$(os)
if [ "$os" -d $os ]; then
    if [ -d $os ]; then
        linkFiles $dotfiles_directory/$os
    fi
    install_script="install_$os.sh"
    if [ -f $install_script ]; then
        . $install_script
    fi
fi

# npm
type npm &> /dev/null
if [ $? -ne 1 ]; then
    cd $HOME
    npm install
fi

# Vim
cd $HOME/.vim/bundle
[ ! -d neobundle.vim ] && git clone https://github.com/Shougo/neobundle.vim neobundle.vim
