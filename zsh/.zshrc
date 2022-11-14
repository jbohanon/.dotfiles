export EDITOR=nvim
# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:/opt/local/bin:$PATH


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
alias sshdev='ssh jacob@192.168.10.70'
alias sshdevdesktop='ssh jacob@192.168.10.165'
alias cddf='cd $HOME/.dotfiles'
alias nvdf='nvim $HOME/.dotfiles/README.md'

alias cls='clear'
export PATH="/opt/homebrew/opt/protobuf@3.6/bin:$PATH"

for conf in "$HOME/.config/zsh/config.d/"*.zsh; do
  source "${conf}"
done
unset conf

[[ -s "/home/jacob/.gvm/scripts/gvm" ]] && source "/home/jacob/.gvm/scripts/gvm"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
