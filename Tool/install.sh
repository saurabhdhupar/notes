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
brew install doitlive

# quick look
brew cask install qlmarkdown
brew cask install qlcolorcode
brew cask install qlstephen
brew cask install quicklook-json
brew cask install qlprettypatch
brew cask install quicklook-csv
brew cask install betterzipql
brew cask install qlimagesize
brew cask install webpquicklook
brew cask install suspicious-package
# brew cask install quicklookase
# brew cask install qlvideo
# brew cask install provisionql
# brew cask install quicklookapk
# brew cask install quicklook-pat
