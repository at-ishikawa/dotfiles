STATIC_COMMON_DIR_PREFIX=static/common
STATIC_COMMON_SOURCE_LINK_FILES=$(shell ls -A $(STATIC_COMMON_DIR_PREFIX))

UNAME = $(shell uname)
ifeq ($(UNAME),Linux)
OS=linux
DISTRIBUTION=(lsb_release -si)
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

prerequisite/Ubuntu:
	sudo apt install git \
		curl \
		python-is-python3 \
		fish \
		emacs

prerequisite/mac/:


.PHONY: install install/mac
install: link/all install/common install/$(OS)


.PHONY: install/common
install/common:
	$(shell which npm && cd $(HOME) && npm install)
	if [ ! -d "$(HOME)/.vim/bundle/neobundle.vim" ]; then \
		mkdir -p $(HOME)/.vim/bundle \
		git clone https://github.com/Shougo/neobundle.vim $(HOME)/.vim/bundle/neobundle.vim; \
	fi
	curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish

.PHONY: install/mac/brew install/mac/emacs
install/mac: install/mac/brew install/mac/emacs
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

install/mac/emacs:
	# Emacs
	# https://qiita.com/makky_tyuyan/items/d692e1fe2aeba979bc11
	brew install cask
	$(eval CASK_VERSION=$(shell cask --version))
	ln -sfn /usr/local/Cellar/cask/$(CASK_VERSION) $(HOME)/.cask \
	cd ~/.emacs.d && cask install

install/linux:
	sudo chsh -s $(shell which fish)
	echo $(shell which fish) | sudo tee -a /etc/shells
	# Emacs
	if [ ! -d $(HOME)/.cask ]; then \
		curl -fsSL https://raw.githubusercontent.com/cask/cask/master/go | python; \
	fi
	sudo apt update -y
	sudo apt install golang-go
	go get github.com/x-motemen/ghq
	sudo apt install fzf
	cd ~/.emacs.d && cask install

.PHONY: link/all link/common
link/all: link/common

link/common:
	$(foreach f,$(STATIC_COMMON_SOURCE_LINK_FILES),$(call linkFile,$(STATIC_COMMON_DIR_PREFIX)/$(f),$(HOME)/$(f)))
