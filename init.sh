#Install zsh
#Install neovim
#Install ripgrep
#Install fd
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt update && sudo apt install -y zsh neovim ripgrep fd-find fzf
#Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
#Install oh-my-zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
#install vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
#Clone dotfiles
cd ~ && git clone https://github.com/jbohanon/.dotfiles
#Make directories & symlinks
mkdir $HOME/.config
ln -s $HOME/.dotfiles/zsh $HOME/.config/zsh
ln -s $HOME/.dotfiles/nvim $HOME/.config/nvim
ln -s $HOME/.config/nvim/.vimrc $HOME/.vimrc
ln -s $HOME/.config/zsh/.zshrc $HOME/.zshrc
#Install powerline-fonts
sudo apt install fonts-powerline
#Install starship
curl -sS https://starship.rs/install.sh | sh
#Install mygvm
mkdir $HOME/go
mkdir -p $HOME/.go/downloads
ln -s $HOME/.dotfiles/zsh/mygvm /usr/local/bin/mygvm

#Install Go
mygvm go1.18.6
