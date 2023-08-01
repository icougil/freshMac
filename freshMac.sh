#/bin/bash

# Mac will ask for installing command line developer tools
# git
#xcode-select --install

# oh-my-zsh
if [ "$SHELL" != "/bin/zsh" ]
then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi
# oh-my-zsh

# brew - https://brew.sh/
if test ! $(which brew); then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# sdkman - sdkman.io
if test ! -d $HOME/.sdkman; then
    curl -s "https://get.sdkman.io" | bash
fi
source "$HOME/.sdkman/bin/sdkman-init.sh"
# sdkman will not work if we try to use the shell with -e -x
CMD="sdk install"
apps=( java maven groovy gradle )
for app in "${apps[@]}"
do
    $CMD $app
done
# sdkman - sdkman.io

# install all the apps
brew bundle

# remove the installers
brew cleanup -s
# we can also remove all the installers from the brew cache folder...
# rm -rf ${brew --cache}

# make default bash the new one - https://apple.stackexchange.com/questions/193411/update-bash-to-version-4-0-on-osx
chsh -s /usr/local/bin/bash

# iterm2 - integration and utilities
curl -L https://iterm2.com/misc/install_shell_integration_and_utilities.sh | bash

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
gem install bundle

# jekyll
gem install jekyll bundler

# rust
curl https://sh.rustup.rs -sSf | sh

# lines of code
cargo install loc

# python zlib missing - https://stackoverflow.com/questions/34200602/the-python-zlib-extension-was-not-compiled-on-mac-os-x-10-11-1
#sudo installer -pkg /Library/Developer/CommandLineTools/Packages/macOS_SDK_headers_for_macOS_10.14.pkg -target /
# problems installing python in Macos - https://stackoverflow.com/questions/51551557/pyenv-build-failed-installing-python-on-macos
# SDKROOT=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk MACOSX_DEPLOYMENT_TARGET=10.14 
# not needed anymore on Mojave?
pyenv install 2.7.13
pyenv local 2.7.13

# install pip, easy install is deprecated - https://stackoverflow.com/questions/17271319/how-do-i-install-pip-on-macos-or-os-x
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && sudo python get-pip.py && rm get-pip.py

# youtoube upload - https://github.com/tokland/youtube-upload
pip3 install --upgrade google-api-python-client progressbar2
pip3 install progressbar
wget https://github.com/tokland/youtube-upload/archive/master.zip
unzip master.zip
cd youtube-upload-master && sudo python setup.py install
cd .. && rm -rf youtube-upload-master/ && rm master.zip

# nvm install & use latest LTS node version
nvm install --lts
nvm use --lts

# https://github.com/powerline/fonts.git

# tocdoc
npm install -g doctoc

# dredd
npm install -g dredd

# markdown-to-slides
npm install markdown-to-slides -g

# serverless
npm install -g serverless

# customizations on Macos
# show dot files
defaults write com.apple.finder AppleShowAllFiles -boolean true; killall Finder
# required by xdotool to enable XTEST in our X11 server
defaults write org.x.X11 enable_test_extensions -boolean true

# fix missing extension for Box.net - https://community.box.com/t5/Desktop-and-Mobile-Forum/Box-Sync-for-Mac-Finder-Extension-Missing/td-p/9986
pluginkit -a /Applications/Box\ Sync.app/Contents/Plugins/FinderSyncExt.appex

# powerlevel 10k fonts for oh-my-zsh
brew install "romkatv/powerlevel10k/powerlevel10k"
p10k configure

# https://support.shinywhitebox.com/hc/en-us/articles/204161459-Installing-iShowU-Audio-Capture-Mojave-and-earlier- - driver for record audio from computer
wget https://downloads.shinywhitebox.com/driver/latest/


echo "---"
echo "Done !"
echo "Time to run 'mackup restore' and after all link the .ssh files"
echo "---"
echo "mkdir $HOME/.ssh"
echo "ln -s $HOME/Dropbox/Mackup/.ssh/id_rsa ~/.ssh/id_rsa"
echo "ln -s $HOME/Dropbox/Mackup/.ssh/id_rsa.pub ~/.ssh/id_rsa.pub"
echo "ln -s $HOME/Dropbox/Mackup/.ssh/known_hosts ~/.ssh/known_hosts"
echo "chmod 400 ~/.ssh/id_rsa"
echo "ssh-add -K ~/.ssh/id_rsa"
echo ""
echo "locate XXX"
echo "sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist"
echo "---" 
echo "Time to run prepare 'crontab' after setting up Box"
echo ""
echo "ln -s $HOME/Box/pers/crontab.md ~/crontab"
echo "crontab $HOME/crontab"
echo ""