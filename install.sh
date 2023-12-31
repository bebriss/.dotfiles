#!/bin/bash
username=$(id -u -n 1000)
builddir=$(pwd)

# UPDATES 
apt update
apt upgrade -y

# ESSENTIAL PROGRAMS
apt install -y i3-wm feh alacritty rofi lightdm polybar tmux ranger pulseaudio picom gh chromium
apt install -y maim xclip thunar unzip wget curl stow zsh pavucontrol build-essential

# DIRECTORIES
cd $builddir
mkdir -p /home/$username/.config
mkdir -p /home/$username/.fonts
mkdir -p /home/$username/Pictures
mkdir -p /home/$username/Pictures/backgrounds
cp bg.png /home/$username/Pictures/backgrounds/

# NVIM
cd /home/$username
wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz
tar xzvf nvim-linux64.tar.gz
sudo cp nvim-linux64/bin/* /usr/bin/
sudo cp -r nvim-linux64/lib/* /usr/lib/
sudo cp -r nvim-linux64/share/* /usr/share/
sudo update-icon-caches /usr/share/icons/*
rm nvim-linux64.tar.gz
rm -rf nvim-linux64

# SPOTIFY
curl -sS https://download.spotify.com/debian/pubkey_7A3A762FAFD4A51F.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
apt-get update && sudo apt-get -y install spotify-client

# DISCORD
wget "https://discord.com/api/download?platform=linux&format=deb" -O discord.deb
apt install -y ./discord.deb
rm discord.deb

# FONTS 
cd $builddir 
apt install fonts-jetbrains-mono -y 
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip
unzip JetBrainsMono.zip -d /home/$username/.fonts
chown $username:$username /home/$username/.fonts/*
fc-cache -vf
rm ./JetBrainsMono.zip

# TMUX PLUGIN MANAGER
git clone https://github.com/tmux-plugins/tpm /home/$username/.tmux/plugins/tpm

# NVCHAD NVIM DISTRIBUTION
git clone https://github.com/NvChad/NvChad /home/$username/.config/nvim --depth 1

chown -R $username:$username /home/$username
