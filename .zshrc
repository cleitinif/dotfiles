# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#
# ~/.zshrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Set to superior editing mode
set -o vi

# keybinds
clear-terminal() { tput reset; zle redisplay; }
zle -N clear-terminal
bindkey '^L' clear-terminal

# ~~~~~~~~~~~~~~~ Environment Variables ~~~~~~~~~~~~~~~~~~~~~~~~
export VISUAL=nvim
export EDITOR=nvim

export REPOS="$HOME/repos"
export GITUSER="cleitinif"

export GOBIN="$HOME/.local/bin"
export GOPATH="$HOME/go/"
export ZSH="$HOME/.oh-my-zsh"
# ~~~~~~~~~~~~~~~ Path configuration ~~~~~~~~~~~~~~~~~~~~~~~~
PATH="$PATH:$HOME/.local/bin:/home/linuxbrew/.linuxbrew/bin:$HOME/.cask/bin"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# ~~~~~~~~~~~~~~~ History ~~~~~~~~~~~~~~~~~~~~~~~~

export HISTFILE=~/.histfile
export HISTSIZE=25000
export SAVEHIST=25000
export HISTCONTROL=ignorespace


# ~~~~~~~~~~~~~~~~~~ Zsh config ~~~~~~~~~~~~~~~~~~~~
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git helm kubectl aws docker terraform docker-compose zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
autoload -U compinit; compinit

export PNPM_HOME="/home/cleitin/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

if [ -f ~/.zsh_aliases ]; then
    . ~/.zsh_aliases
fi

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

eval "$(fzf --zsh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
