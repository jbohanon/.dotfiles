#!/usr/bin/env bash
# Bootstrap script for Ubuntu. Safe to re-run.
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIN="$HOME/.local/bin"
NVIM_VERSION="${NVIM_VERSION:-stable}"
NVM_VERSION="v0.40.3"
GO_VERSION="go1.22.0"

case "$(uname -m)" in
  x86_64)  ARCH=amd64; NVIM_ARCH=x86_64 ;;
  aarch64) ARCH=arm64; NVIM_ARCH=arm64 ;;
  *) echo "unsupported architecture: $(uname -m)" >&2; exit 1 ;;
esac

mkdir -p "$BIN" "$HOME/.config"
export PATH="$BIN:$PATH"

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

have() { command -v "$1" >/dev/null 2>&1; }

link() { # link <src> <dest>; backs up real files, replaces stale symlinks
  local src=$1 dest=$2
  if [[ -e $dest && ! -L $dest ]]; then
    mv "$dest" "$dest.bak.$(date +%s)"
  fi
  ln -sfn "$src" "$dest"
}

install_packages() {
  sudo apt-get update
  sudo apt-get install -y git curl tar tmux zsh ripgrep fd-find fzf tree fonts-powerline
  if have fdfind && ! have fd; then
    ln -sfn "$(command -v fdfind)" "$BIN/fd"
  fi
}

install_neovim() {
  have nvim && return
  local name="nvim-linux-$NVIM_ARCH"
  curl -fsSL -o "$TMP/nvim.tar.gz" \
    "https://github.com/neovim/neovim/releases/download/$NVIM_VERSION/$name.tar.gz"
  rm -rf "$HOME/.local/nvim"
  mkdir -p "$HOME/.local/nvim"
  tar -xzf "$TMP/nvim.tar.gz" -C "$HOME/.local/nvim" --strip-components=1
  ln -sfn "$HOME/.local/nvim/bin/nvim" "$BIN/nvim"
}

link_configs() {
  for d in zsh nvim tmux zellij mygvm; do
    link "$DOTFILES/$d" "$HOME/.config/$d"
  done
  link "$DOTFILES/.gitconfig" "$HOME/.gitconfig"
  link "$DOTFILES/zsh/.zshrc" "$HOME/.zshrc"
  link "$DOTFILES/zsh/merge-main.sh" "$BIN/merge-main.sh"
  link "$DOTFILES/zsh/gitclone.sh" "$BIN/gitclone.sh"
}

install_starship() {
  have starship && return
  curl -fsSL https://starship.rs/install.sh -o "$TMP/starship.sh"
  sh "$TMP/starship.sh" -y -b "$BIN"
}

install_go() {
  mkdir -p "$HOME/go" "$HOME/.go/downloads"
  link "$DOTFILES/mygvm/mygvm" "$BIN/mygvm"
  mygvm install "$GO_VERSION"
}

install_kubectl() {
  have kubectl && return
  local ver
  ver="$(curl -fsSL https://dl.k8s.io/release/stable.txt)"
  curl -fsSL -o "$BIN/kubectl" "https://dl.k8s.io/release/$ver/bin/linux/$ARCH/kubectl"
  chmod 0755 "$BIN/kubectl"
}

install_nvm() {
  [[ -d $HOME/.nvm ]] && return
  curl -fsSL "https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_VERSION/install.sh" | PROFILE=/dev/null bash
}

install_ohmyzsh() {
  if [[ ! -d $HOME/.oh-my-zsh ]]; then
    curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -o "$TMP/omz.sh"
    RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh "$TMP/omz.sh" --unattended
  fi
  local custom="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins" p
  for p in zsh-autosuggestions zsh-syntax-highlighting; do
    [[ -d $custom/$p ]] || git clone --depth 1 "https://github.com/zsh-users/$p" "$custom/$p"
  done
}

install_packages
install_neovim
link_configs
install_starship
install_go
install_kubectl
install_nvm
install_ohmyzsh

if [[ $(basename "${SHELL:-}") != zsh ]]; then
  echo "Done. Run 'chsh -s $(command -v zsh)' to make zsh your login shell."
else
  echo "Done."
fi
