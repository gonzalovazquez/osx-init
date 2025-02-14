#!/usr/bin/env bash

defaults write com.apple.finder AppleShowAllFiles YES; # show hidden files
defaults write com.apple.dock persistent-apps -array; # remove icons in Dock
defaults write com.apple.dock tilesize -int 36; # smaller icon sizes in Dock
defaults write com.apple.dock autohide -bool true; # turn Dock auto-hidng on
defaults write com.apple.dock autohide-delay -float 0; # remove Dock show delay
defaults write com.apple.dock autohide-time-modifier -float 0; # remove Dock show delay
defaults write com.apple.dock orientation left; # place Dock on the right side of screen
defaults write NSGlobalDomain AppleShowAllExtensions -bool true; # show all file extensions
killall Dock 2>/dev/null;
killall Finder 2>/dev/null;

echo "Setting up ~/.bash_profile...";
touch ~/.bash_profile;
echo "export PS1=\"\w $ \";" >> ~/.bash_profile;

echo "Setting up ~/.vimrc...";
touch ~/.vimrc;
echo "get number" >> ~/.vimrc;
echo "" >> ~/.vimrc;
echo "highlight OverLength ctermbg=red ctermfg=white guibg=#592929" >> ~/.vimrc;
echo "match OverLength /\\%81v.\\+/" >> ~/.vimrc;

# install Xcode Command Line Tools
# https://github.com/timsutton/osx-vm-templates/blob/ce8df8a7468faa7c5312444ece1b977c1b2f77a4/scripts/xcode-cli-tools.sh
touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress;
PROD=$(softwareupdate -l |
  grep "\*.*Command Line" |
  head -n 1 | awk -F"*" '{print $2}' |
  sed -e 's/^ *//' |
  tr -d '\n')
softwareupdate -i "$PROD" -v;

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)";
brew install \
  caskroom/cask/brew-cask \
  cmake	\
  git \
  mongodb \
  mysql \
  nmap \
  node \
  openssl \
  privoxy \
  pssh \
  python \
  redis \
  tor \
;
brew tap caskroom/versions;
brew cask install \
  1password \
  signal \
  clion-rc-bundled \
  firefox \
  flash \
  java \
  keka \
  skype \
  spectacle \
  spotify \
  vlc \
;

git config --global credential.helper osxkeychain; # activate git credentials storage
git config --global push.default simple; # default Git push behavior is set to `simple`

echo "Setting up MongoDB...";
sudo mkdir -p /data/db;
ln -sfv /usr/local/opt/mongodb/*.plist ~/Library/LaunchAgents;
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mongodb.plist;

# install Docker Toolbox (needed to load OS X on VirtualBox)
## @TODO: Add Docker 
