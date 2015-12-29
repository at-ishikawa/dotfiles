#! /bin/bash

command_exists brew || return 0

if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

function brew() {
    trap "return" EXIT
    `which brew` $@
    for option in $@
    do
	if [ "$option" = "install" ]; then
	    brew list > $BREW_INSTALLED_PACKAGES_FILE
	fi
    done
}
