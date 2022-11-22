#!/bin/bash

which apt && PKGINST='sudo apt install -y' && PKGUPD='sudo apt update' || which dnf && PKGINST='sudo dnf install -y' && PKGUPD='sudo dnf update -y'

echo "PKGUPD: ${PKGUPD}"
echo "PKGINST: ${PKGINST}"
#Install zsh
#Install neovim
#Install ripgrep
#Install fd
which apt && sudo add-apt-repository ppa:neovim-ppa/stable || which dnf && sudo dnf copr enable agriffis/neovim-nightly
[[ $PKGINST != '' ]] && $PKGUPD && $PKGINST zsh neovim ripgrep fd-find fzf
#Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
#Install oh-my-zsh plugins
if [[ -d $HOME/.oh-my-zsh ]]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi
#install vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
#Clone dotfiles
[[ ! -d $HOME/.dotfiles ]] && cd $HOME && git clone https://github.com/jbohanon/.dotfiles
#Make directories & symlinks
mkdir $HOME/.config
ln -s $HOME/.dotfiles/zsh $HOME/.config/zsh
ln -s $HOME/.dotfiles/nvim $HOME/.config/nvim
ln -s $HOME/.config/nvim/init.vim $HOME/.vimrc
ln -s $HOME/.config/zsh/.zshrc $HOME/.zshrc
#Install powerline-fonts
which apt && $PKGINST fonts-powerline || which dnf && $PKGINST powerline-fonts
#Install starship
curl -sS https://starship.rs/install.sh | sh
#Install mygvm
mkdir $HOME/go
mkdir -p $HOME/.go/downloads
sudo ln -s $HOME/.dotfiles/zsh/mygvm /usr/local/bin/mygvm

#Install Go
mygvm go1.18.6

#link gitconfig
ln -s $HOME/.dotfiles/.gitconfig $HOME/.gitconfig
