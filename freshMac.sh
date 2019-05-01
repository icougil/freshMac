#/bin/bash
set -e -x

# Mac will ask for installing command line developer tools
# git
#xcode-select --install

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
# oh-my-zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# brew - https://brew.sh/
if test ! $(which brew); then
 	echo /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update bundle
brew tap homebrew/bundle
# install all the apps
brew bundle

# remove the installers
brew cleanup -s
# we can also remove all the installers from the brew cache folder...
# rm -rf ${brew --cache}

# make default bash the new one - https://apple.stackexchange.com/questions/193411/update-bash-to-version-4-0-on-osx
chsh -s /usr/local/bin/bash

# sdkman - sdkman.io
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
#
CMD="sdk install"
apps=( java maven groovy gradle )
for app in "${apps[@]}"
do
 $CMD $app
done

brew install "maven-completion"
brew cask install android-sdk

# iterm2 - integration and utilities
curl -L https://iterm2.com/misc/install_shell_integration_and_utilities.sh | bash

sudo easy_install pip
sudo pip install virtualenv

# upgrade gems
sudo gem update --system

# install updated ruby versions (most updated that cames with macOS)
# rbenv - https://github.com/rbenv/rbenv#homebrew-on-macos
echo "Setting up rbenv..."
rbenv init
echo "Now, close this Terminal and open a new one so your changes take effect"
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-doctor | bash
rbenv install 2.4.1
rbenv local 2.4.1
# install jekyll
gem install jekyll bundler

# mega.nz
curl -fsSL https://mega.nz/MEGAsyncSetup.dmg -o MEGAsyncSetup.dmg && open MEGAsyncSetup.dmg

# Tor browser
TOR_VERSION="8.0.8"
curl -fsSL https://www.torproject.org/dist/torbrowser/8.0.8/TorBrowser-$TOR_VERSION-osx64_en-US.dmg -o TorBrowser.dmg && open TorBrowser.dmg

# rust
curl https://sh.rustup.rs -sSf | sh

# lines of code
cargo install loc

# pyenv install env
# python zlib missing - https://stackoverflow.com/questions/34200602/the-python-zlib-extension-was-not-compiled-on-mac-os-x-10-11-1
sudo installer -pkg /Library/Developer/CommandLineTools/Packages/macOS_SDK_headers_for_macOS_10.14.pkg -target /
pyenv install 2.7.13
pyenv local 2.7.13

# youtoube upload - https://github.com/tokland/youtube-upload
pip install --upgrade google-api-python-client progressbar2
easy_install progressbar
wget https://github.com/tokland/youtube-upload/archive/master.zip
unzip master.zip
cd youtube-upload-master
python setup.py install
cd ..
rm -rf youtube-upload-master/
rm master.zip

# https://github.com/powerline/fonts.git

# tocdoc
npm install -g doctoc

# dredd
npm install -g dredd

# markdown-to-slides
npm install markdown-to-slides -g
