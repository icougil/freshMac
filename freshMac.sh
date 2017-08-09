#/bin/bash
set -e -x

# Mac will ask for installing command line developer tools
# git
xcode-select --install

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

# Link Cask Apps to Alfred
brew cask alfred link

brew cleanup -s
# we can also remove all the installers from the brew cache folder...
# rm -rf ${brew --cache}
brew cask cleanup

# sdkman - sdkman.io
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"

$CMD="echo sdk install"
apps=( java maven groovy gradle )
for app in "${apps[@]}"
do
	$CMD $app
done
