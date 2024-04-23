#!/bin/bash

set -e

export XDG_CONFIG_HOME="$HOME"/.config

mkdir -p "$XDG_CONFIG_HOME"/alacritty
mkdir -p "$XDG_CONFIG_HOME"/k9s

if ! [ -d "$XDG_CONFIG_HOME/alacritty/themes" ]; then
  git clone https://github.com/alacritty/alacritty-theme "$XDG_CONFIG_HOME"/alacritty/themes
fi

if ! [ -d "$HOME/.tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm "$HOME"/.tmux/plugins/tpm
fi

# Symbolic links
#ln -sf "$PWD/.zsh_profile" "$HOME"/.zsh_profile
#ln -sf "$PWD/.zshrc" "$HOME"/.zshrc
#ln -sf "$PWD/.zsh_aliases" "$HOME"/.zsh_aliases
ln -sf "$PWD/.bashrc" "$HOME/.bashrc"
ln -sf "$PWD/.bash_profile" "$HOME/.bash_profile"
ln -sf "$PWD/k9s/skin.yml" "$XDG_CONFIG_HOME"/k9s/skins/skin.yml
ln -sf "$PWD/alacritty.toml" "$XDG_CONFIG_HOME"/alacritty/alacritty.toml
ln -sf "$PWD/.tmux.conf" "$HOME"/.tmux.conf
ln -sf "$PWD/better-vim/better-vim.lua" "$XDG_CONFIG_HOME"/better-vim/better-vim.lua

# install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

sudo apt update
sudo apt upgrade -y
sudo apt install gcc g++ unzip apt-transport-https ca-certificates curl ripgrep -y

# Install alacritty in MacOS
# brew install --cask alacritty

brew install derailed/k9s/k9s starship kubectl go lazygit fd fzf gh tmux fluxcd/tap/flux

# Install NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

corepack enable pnpm

echo "Insert your Bettervim license"
read bettervim_license

if [ -z $bettervim_license ] 
then
  echo "Skipping Bettervim installation"
else
  curl -L https://bettervim.com/install/$bettervim_license | bash
fi

#if ! [ -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
#  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
#fi
#if ! [ -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
#  git clone https://github.com/zsh-users/zsh-autosuggestions.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
#fi
#if ! [ -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]; then
#  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
#fi
#if ! [ -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting" ]; then
#  git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting"
#fi
#if ! [ -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autocomplete" ]; then
#  git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autocomplete"
#fi

#sudo apt install zsh -y
#sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
