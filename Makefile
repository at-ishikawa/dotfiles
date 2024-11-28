SHELL := /bin/bash

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
	sudo apt update -y && sudo apt upgrade -y
	sudo apt install -y software-properties-common \
		python3 \
		python3-venv

	# Downloading via ppa:ansible/ansible has a problem to run ansible-test
	# https://www.cyberciti.biz/faq/how-to-install-and-configure-latest-version-of-ansible-on-ubuntu-linux/
	# sudo apt install -y software-properties-common && sudo apt-add-repository -y ppa:ansible/ansible
	# sudo apt install -y ansible

prerequisite/mac/:
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	eval "$$(/opt/homebrew/bin/brew shellenv)"
	brew install python3
	# brew install ansible

.PHONY: prepare install update install/mac install/linux
prepare: prerequisite
	python3 -m venv venv
	source venv/bin/activate; \
	pip install -r requirements.txt; \
	ansible-galaxy collection install community.general; \
	ansible-playbook --diff --check bootstrap.yml

install:
	ansible-playbook --verbose --diff --ask-become-pass core.yml
	ansible-playbook --verbose --diff --ask-become-pass bootstrap.yml

update:
	ansible-playbook --diff --ask-become-pass bootstrap.yml

test:
	ansible-test sanity roles bootstrap.yml
	# For some reasons, --docker option doesn't work for an integration tet
	# ansible-test integration --docker ubuntu2204
	ansible-test integration
