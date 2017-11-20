#!/usr/bin/env sh

brew update

# go
brew install dep
brew install glide
go get -u github.com/google/gops
# tool
brew install doitlive
# editor
brew cask install sublime-text
# front-end
brew cask install postman
brew install httpie
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.5/install.sh | bash
nvm install 8.7.0
# java
brew cask install java
brew install maven
# python
brew install pyenv