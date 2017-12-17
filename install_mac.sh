#! /bin/bash

# Install Alfred, Google Chrome

# homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update

# Emacs
# https://qiita.com/makky_tyuyan/items/d692e1fe2aeba979bc11
brew install cask
cask_version=$(cask --version)
ln -sfn /usr/local/Cellar/cask/$cask_version $HOME/.cask

brew tap caskroom/cask
brew cask install emacs
cd ~/.emacs.d
cask
