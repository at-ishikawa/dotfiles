#! /bin/bash

# Install Alfred, Google Chrome

# homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install ansible python
ansible-playbook -i hosts package_mac.yml

brew update

# Emacs
# https://qiita.com/makky_tyuyan/items/d692e1fe2aeba979bc11
brew install cask
cask_version=$(cask --version)
ln -sfn /usr/local/Cellar/cask/$cask_version $HOME/.cask

cd ~/.emacs.d
cask

ln -s /Applications/Docker.app/Contents/Resources/etc/docker.bash-completion $(brew --prefix)/etc/bash_completion.d/docker
ln -s /Applications/Docker.app/Contents/Resources/etc/docker-machine.bash-completion $(brew --prefix)/etc/bash_completion.d/docker-machine
ln -s /Applications/Docker.app/Contents/Resources/etc/docker-compose.bash-completion $(brew --prefix)/etc/bash_completion.d/docker-compose
