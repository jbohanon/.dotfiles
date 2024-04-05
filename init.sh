#!/bin/bash

# Make sure we have our local bin directory
sudo mkdir -p /usr/local/bin

which dnf && PKGINST='sudo dnf install -y' && PKGUPD='sudo dnf update -y' || which apt && PKGINST='sudo apt install -y' && PKGUPD='sudo apt update'

echo "PKGUPD: ${PKGUPD}"
echo "PKGINST: ${PKGINST}"

# Install zsh, neovim, ripgrep, fd
[[ $PKGINST != '' ]] && $PKGUPD && $PKGINST zsh ripgrep fd-find fzf

# Install neovim
pushd /tmp || true
git clone https://github.com/neovim/neovim
pushd neovim \
  && make CMAKE_BUILD_TYPE=RelWithDebInfo \
  && sudo make install
popd || true
rm -rf neovim/
popd || true

# install zellij
curl -L -o "$HOME/Downloads/zellij.tar.gz" "https://github.com/zellij-org/zellij/releases/latest/download/zellij-x86_64-unknown-linux-musl.tar.gz"
tar -zxf "$HOME/Downloads/zellij.tar.gz"
sudo mv zellij /usr/local/bin/zellij
rm "$HOME/Downloads/zellij.tar.gz"


# install vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Make directories & symlinks
mkdir -p $HOME/.config
cp -r ./ $HOME/.dotfiles
ln -s $HOME/.dotfiles/zsh/    $HOME/.config/zsh
ln -s $HOME/.dotfiles/nvim/   $HOME/.config/nvim
ln -s $HOME/.dotfiles/tmux/   $HOME/.config/tmux
ln -s $HOME/.dotfiles/zellij/ $HOME/.config/zellij
ln -s $HOME/.dotfiles/mygvm/ $HOME/.config/mygvm
ln -s $HOME/.config/nvim/init.vim $HOME/.vimrc
mv $HOME/.zshrc $HOME/.zshrc.bak && ln -s $HOME/.config/zsh/.zshrc $HOME/.zshrc

## Install powerline-fonts
which apt && $PKGINST fonts-powerline || which dnf && $PKGINST powerline-fonts

# Install starship
curl -sS https://starship.rs/install.sh | sh

# Install mygvm
mkdir $HOME/go
mkdir -p $HOME/.go/downloads
sudo ln -s $HOME/.dotfiles/mygvm/mygvm /usr/local/bin/mygvm

# Install Go
mygvm install go1.22.0

# Install merge-main.sh
mkdir -p $HOME/.local/bin
sudo ln -s $HOME/.dotfiles/zsh/merge-main.sh $HOME/.local/bin/merge-main.sh

# link gitconfig
ln -s $HOME/.dotfiles/.gitconfig $HOME/.gitconfig

# Install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
rm ./kubectl

# install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install oh-my-zsh plugins
if [[ -d $HOME/.oh-my-zsh ]]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi
