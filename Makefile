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

# Deprecated: Move to ansible
install/mac:
	$(eval BREW_PREFIX=$(shell brew --prefix))
	ln -sfn /Applications/Docker.app/Contents/Resources/etc/docker.bash-completion $(BREW_PREFIX)/etc/bash_completion.d/docker
	ln -sfn /Applications/Docker.app/Contents/Resources/etc/docker-compose.bash-completion $(BREW_PREFIX)/etc/bash_completion.d/docker-compose
	mkdir -p ~/lib
	ln -sfn /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk ~/lib/

# Deprecated: Move to ansible
install/linux: install/linux/$(DISTRIBUTION)

install/linux/Ubuntu: # install/linux/Ubuntu/%
	# Emacs
	# sudo apt update -y
	# sudo apt install -y
	# 	gnome-tweaks \
	# 	gnome-shell-extensions \
	# 	gnome-shell-extension-gpaste \
	# 	gnome-shell-extension-prefs

install/linux/Ubuntu/vscode:
	# https://code.visualstudio.com/docs/setup/linux
	sudo apt install -y wget gpg
	wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
	sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
	sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
	rm -f packages.microsoft.gpg
	sudo apt install -y apt-transport-https
	sudo apt update
	sudo apt install -y code

install/linux/Ubuntu/google-chrome:
	sudo apt install -y wget
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	sudo dpkg -i google-chrome-stable_current_amd64.deb
	rm google-chrome-stable_current_amd64.deb

install/linux/Ubuntu/docker:
	# https://www.howtogeek.com/devops/how-to-install-docker-and-docker-compose-on-linux/
	sudo apt update
	sudo apt install -y apt-transport-https ca-certificates curl gnupg lsb-release
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
	echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(shell lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
	sudo apt update -y
	sudo apt install -y docker-ce docker-ce-cli containerd.io
