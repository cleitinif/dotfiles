#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Set to superior editing mode
set -o vi

# Keybindings
bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'
bind -x '"\C-l":clear'
# ~~~~~~~~~~~~~~~ Environment Variables ~~~~~~~~~~~~~~~~~~~~~~~~

export VISUAL=nvim
export EDITOR=nvim

# directories
export REPOS="$HOME/repos"
export GITUSER="cleitinif"
export DOTFILES="$GHREPOS/dotfiles"

export SCRIPTS="$DOTFILES/scripts"

# Go related. In general all executables and scripts go in .local/bin
export GOBIN="$HOME/.local/bin"
# export GOPATH="$HOME/.local/share/go"
export GOPATH="$HOME/go/"

# ~~~~~~~~~~~~~~~ Path configuration ~~~~~~~~~~~~~~~~~~~~~~~~

PATH="${PATH:+${PATH}:}"$SCRIPTS":"$HOME"/.local/bin" # appending

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"


# ~~~~~~~~~~~~~~~ History ~~~~~~~~~~~~~~~~~~~~~~~~

export HISTFILE=~/.histfile
export HISTSIZE=25000
export SAVEHIST=25000
export HISTCONTROL=ignorespace

# ~~~~~~~~~~~~~~~ Functions ~~~~~~~~~~~~~~~~~~~~~~~~


# ~~~~~~~~~~~~~~~ SSH ~~~~~~~~~~~~~~~~~~~~~~~~
# SSH Script from arch wiki

if ! pgrep -u "$USER" ssh-agent >/dev/null; then
	ssh-agent >"$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! "$SSH_AUTH_SOCK" ]]; then
	source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null

fi


# Only run on Ubuntu

if [[ $(grep -E "^(ID|NAME)=" /etc/os-release | grep -q "ubuntu")$? == 0 ]]; then
	eval "$(ssh-agent -s)" >/dev/null
fi

# adding keys was buggy, add them outside of the script for now
# ssh-add -q ~/.ssh/mischa
# ssh-add -q ~/.ssh/mburg

# ~~~~~~~~~~~~~~~ Prompt ~~~~~~~~~~~~~~~~~~~~~~~~

# Moved to starship 20-03-2024 for all my prompt needs.

eval "$(starship init bash)"

# ~~~~~~~~~~~~~~~ Aliases ~~~~~~~~~~~~~~~~~~~~~~~~


alias v=nvim
# alias vim=nvim

# cd
alias ..="cd .."
alias scripts='cd $SCRIPTS'

# Repos

alias repos='cd $REPOS'
alias c="clear"

# ls
alias ls='ls --color=auto'
alias ll='ls -la'
# alias la='exa -laghm@ --all --icons --git --color=always'
alias la='ls -lathr'

# finds all files recursively and sorts by last modification, ignore hidden files
alias last='find . -type f -not -path "*/\.*" -exec ls -lrt {} +'

alias t='tmux'
alias e='exit'

# git
alias gp='git pull'
alias gs='git status'
alias lg='lazygit'

# ricing
alias eb='v ~/.bashrc'
alias sbr='source ~/.bashrc'

# terraform
alias tf='terraform'
alias tp='terraform plan'

# kubectl
alias k='kubectl'
source <(kubectl completion bash)
complete -o default -F __start_kubectl k
alias kgp='kubectl get pods'
alias kc='kubectx'
alias kn='kubens'

#alias kcs='kubectl config use-context admin@homelab-staging'
#alias kcp='kubectl config use-context admin@homelab-production'

# flux

source <(flux completion bash)
alias fgk='flux get kustomizations'

# cilium
source <(cilium completion bash)

# fzf aliases
# use fp to do a fzf search and preview the files

alias fp="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"
# search for a file with fzf and open it in vim
alias vf='v $(fp)'


# sourcing
source "$HOME/.privaterc"

if [[ "$OSTYPE" == "darwin"* ]]; then

	source "$HOME/.fzf.bash"
	# echo "I'm on Mac!"

	# brew bash completion
	[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"
else
	#	source /usr/share/fzf/key-bindings.bash
	#	source /usr/share/fzf/completion.bash
	[ -f ~/.fzf.bash ] && source ~/.fzf.bash
fi


### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
### export PATH="/Users/mischa/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

# Only needed for npm install on WSL
#export NVM_DIR="$HOME/.config/nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
