#/bin/bash
set -e -x

# Mac will ask for installing command line developer tools
# git
#xcode-select --install

# brew - https://brew.sh/
if test ! $(which brew); then
	echo /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update

# bundle
brew tap homebrew/bundle
brew bundle

# apps=( atom sublime iterm2 intellij-idea docker postman dupeguru soapui xmind dbeaver-community google-chrome google-hangouts spectacle vlc dropbox box-sync firefox skype spotify charles google-backup-and-sync alfred flux slack telegram libreoffice android-file-transfer android-sdk the-unarchiver gpgtools lastpass enpass jdownloader tunnelblick qbittorrent inkscape gimp dbvisualizer dbeaver-community jd-gui virtualbox minikube wireshark );
# CMD="echo brew cask install"
# for app in "${apps[@]}"
# do
# 	$CMD $app
# done
# 
# CMD="echo brew install"
# apps=( wget tree jq nmap bash-completion bash-git-prompt h2 rbenv httpie go mas lynx pyenv node vcprompt git# -flow kubectl brew-cask-completion )
# for app in "${apps[@]}"
# do
# 	$CMD $app
# done

brew cleanup -s
# we can also remove all the installers from the brew cache folder...
# rm -rf ${brew --cache}
brew cask cleanup

# sdkman - sdkman.io
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"

CMD="sdk install"
apps=( java maven groovy gradle )
for app in "${apps[@]}"
do
	$CMD $app
done

brew install "maven-completion"

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
TOR_VERSION="7.0.5"
curl -fsSL https://github.com/TheTorProject/gettorbrowser/releases/download/v$TOR_VERSION/TorBrowser-$TOR_VERSION-osx64_en-US.dmg -o TorBrowser.dmg && open TorBrowser.dmg

# rust
curl https://sh.rustup.rs -sSf | sh

# lines of code
cargo install loc

# pyenv install env
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

# tocdoc
npm install -g doctoc
