STATIC_COMMON_DIR_PREFIX=static/common
STATIC_COMMON_SOURCE_LINK_FILES=$(shell ls -A $(STATIC_COMMON_DIR_PREFIX))

UNAME = $(shell uname)
ifeq ($(UNAME),Linux)
OS=linux
endif
ifeq ($(UNAME),Darwin)
OS=mac
endif

define linkFile
	ln -sfn $(realpath $(1)) $(abspath $(2))

endef


.PHONY: install install/mac
install: link/all install/common install/$(OS)


.PHONY: install/common
install/common:
	$(shell which npm && cd $(HOME) && npm install)
	cd $(HOME)/.vim/bundle && git clone https://github.com/Shougo/neobundle.vim neobundle.vim


.PHONY: install/mac/brew install/mac/emacs
install/mac: install/mac/brew install/mac/emacs
	ln -sfn /Applications/Docker.app/Contents/Resources/etc/docker.bash-completion $(shell brew --prefix)/etc/bash_completion.d/docker
	ln -sfn /Applications/Docker.app/Contents/Resources/etc/docker-machine.bash-completion $(shell brew --prefix)/etc/bash_completion.d/docker-machine
	ln -sfn /Applications/Docker.app/Contents/Resources/etc/docker-compose.bash-completion $(shell brew --prefix)/etc/bash_completion.d/docker-compose

install/mac/brew:
	/usr/bin/ruby -e "$(shell curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	brew install ansible python
	ansible-playbook -i hosts package_mac.yml
	brew update

install/mac/emacs:
	# Emacs
	# https://qiita.com/makky_tyuyan/items/d692e1fe2aeba979bc11
	brew install cask
	ln -sfn /usr/local/Cellar/cask/$(shell cask --version) $(HOME)/.cask
	cd ~/.emacs.d && cask install


.PHONY: link/all link/common
link/all: link/common

link/common:
	$(foreach f,$(STATIC_COMMON_SOURCE_LINK_FILES),$(call linkFile,$(STATIC_COMMON_DIR_PREFIX)/$(f),$(HOME)/$(f)))
