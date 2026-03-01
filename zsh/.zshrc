export ZSH="$HOME/.oh-my-zsh"

export ZSH_CUSTOM="$HOME/dotfiles/zsh/custom"

ZSH_THEME="robbyrussell"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

alias gs="git status"
alias dot="cd ~/dotfiles"
alias reload="source ~/.zshrc"
