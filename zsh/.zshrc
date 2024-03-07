export EDITOR=nvim
# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:/opt/local/bin:$PATH

ulimit -n 65536 200000
ulimit -f unlimited

# eksctl
fpath=($fpath ~/.zsh/completion)

# License keys for enterprise installations
SECRET_PATH="${SECRET_PATH:-$HOME/.dotfiles/ignore/secrets}"
if [[ -f $SECRET_PATH ]]; then
  while read -r secret
  do
      eval $secret
  done <  $SECRET_PATH
else
  echo "could not find secrets file at $SECRET_PATH"
  echo "expected file containing secrets export statements"
  echo ""
  echo "see https://github.com/settings/tokens for creating a github access token"
  echo "export GITHUB_TOKEN=<token>"
  echo ""
  echo "see https://github.com/solo-io/licensing for generating licenses"
  echo "export GLOO_LICENSE_KEY=<gloo edge enterprise license>"
  echo "export GLOO_MESH_LICENSE_KEY=<gloo mesh enterprise license>"
fi

alias pls='sudo'
alias mm='merge-main.sh'
alias gmc='git merge --continue'
alias kci='git commit --allow-empty --message "kick CI" && git push'
alias cddf='cd $HOME/.dotfiles'
alias nvdf='cddf && nvim $HOME/.dotfiles/README.md'
alias cdjb='cd $HOME/src/github.com/jbohanon'

if [[ $(uname) == Linux ]]; then
  alias pbcopy='xsel --clipboard --input'
  alias pbpaste='xsel --clipboard --output'
fi

alias cls='clear'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

for conf in "$HOME/.config/zsh/config.d/"*.zsh; do
  source "${conf}"
done
unset conf

export TERM=xterm-256color

export STARSHIP_CONFIG=~/.config/zsh/starship.toml

eval "$(starship init zsh)"

