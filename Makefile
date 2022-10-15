STATIC_COMMON_DIR_PREFIX=static/common
STATIC_COMMON_SOURCE_LINK_FILES=$(shell ls -A $(STATIC_COMMON_DIR_PREFIX))

UNAME = $(shell uname)
ifeq ($(UNAME),Linux)
OS=linux
DISTRIBUTION=$(shell lsb_release -si)
endif
ifeq ($(UNAME),Darwin)
OS=mac
DISTRIBUTION=
endif

define linkFile
	$(eval DESTINATION := $(abspath $(2)))
	ln -sfn $(realpath $(1)) $(DESTINATION)
endef


prerequisite: prerequisite/$(OS)/$(DISTRIBUTION)

prerequisite/linux/Ubuntu:
	sudo apt install git \
		curl \
		fish

prerequisite/mac/:


.PHONY: install install/mac
install: prerequisite link/all install/common install/$(OS)


.PHONY: install/common
install/common:
	$(shell which npm && cd $(HOME) && npm install)
	if [ ! -d "$(HOME)/.vim/bundle/neobundle.vim" ]; then \
		mkdir -p $(HOME)/.vim/bundle \
		git clone https://github.com/Shougo/neobundle.vim $(HOME)/.vim/bundle/neobundle.vim; \
	fi
	curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish

.PHONY: install/mac/brew 
install/mac: install/mac/brew 
	chsh -s $(shell which fish)
	echo $(shell which fish) | sudo tee -a /etc/shells
	$(eval BREW_PREFIX=$(shell brew --prefix))
	ln -sfn /Applications/Docker.app/Contents/Resources/etc/docker.bash-completion $(BREW_PREFIX)/etc/bash_completion.d/docker
	ln -sfn /Applications/Docker.app/Contents/Resources/etc/docker-compose.bash-completion $(BREW_PREFIX)/etc/bash_completion.d/docker-compose
	mkdir -p ~/lib
	ln -sfn /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk ~/lib/

install/mac/brew:
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install | ruby
ifeq (, $(shell which ansible))
	brew install ansible
endif
ifeq (, $(shell which python))
	brew install python
endif
	ansible-playbook -i hosts package_mac.yml
	brew update

install/linux:
	sudo chsh -s $(shell which fish)
	echo $(shell which fish) | sudo tee -a /etc/shells
	# Emacs
	sudo apt update -y
	sudo apt install golang-go
	sudo apt install fzf

.PHONY: link/all link/common
link/all: link/common

link/common:
	$(foreach f,$(STATIC_COMMON_SOURCE_LINK_FILES),$(call linkFile,$(STATIC_COMMON_DIR_PREFIX)/$(f),$(HOME)/$(f)))
