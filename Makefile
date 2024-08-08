UNAME = $(shell uname)
ifeq ($(UNAME),Linux)
OS=linux
DISTRIBUTION=$(shell lsb_release -si)
endif
ifeq ($(UNAME),Darwin)
OS=mac
DISTRIBUTION=
endif


prerequisite: prerequisite/$(OS)/$(DISTRIBUTION)

prerequisite/linux/Ubuntu:
	# Download the latest ansible version
	# https://www.cyberciti.biz/faq/how-to-install-and-configure-latest-version-of-ansible-on-ubuntu-linux/
	sudo apt update -y && sudo apt upgrade -y
	sudo apt install -y software-properties-common && sudo apt-add-repository -y ppa:ansible/ansible
	sudo apt install -y ansible
	# Use a snap module
	# https://docs.ansible.com/ansible/latest/collections/community/general/snap_module.html
	ansible-galaxy collection install community.general

prerequisite/mac/:
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	eval "$$(/opt/homebrew/bin/brew shellenv)"
	brew install ansible

.PHONY: prepare install update install/mac install/linux
prepare: prerequisite
	ansible-playbook --diff --check bootstrap.yml

install: install/$(OS)
	ansible-playbook --diff --ask-become-pass bootstrap.yml

update:
	ansible-playbook --diff --ask-become-pass bootstrap.yml
