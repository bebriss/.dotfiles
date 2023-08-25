#!/bin/bash
username=$(id -u -n 1000)
builddir=$(pwd)

# UPDATES 
apt update
apt upgrade -y

# ESSENTIAL PROGRAMS
apt install -y i3-wm feh alacritty rofi pulseaudio pavucontrol build-essential lightdm 
apt install -y maim xclip picom thunar unzip wget curl gh stow fzf zsh polybar

# DIRECTORIES
cd $builddir
mkdir -p /home/$username/.config
mkdir -p /home/$username/.fonts
mkdir -p /home/$username/Pictures
mkdir -p /home/$username/Pictures/backgrounds
cp bg.png /home/$username/Pictures/backgrounds/

# NVIM
#cd /home/$username
#wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz
#tar xzvf nvim-linux64.tar.gz
#sudo cp nvim-linux64/bin/* /usr/bin/
#sudo cp -r nvim-linux64/lib/* /usr/lib/
#sudo cp -r nvim-linux64/share/* /usr/share/
#sudo update-icon-caches /usr/share/icons/*
#rm nvim-linux64.tar.gz
#rm -rf nvim-linux64

# FONTS 
cd $builddir 
apt install fonts-jetbrains-mono -y 
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip
unzip JetBrainsMono.zip -d /home/$username/.fonts
chown $username:$username /home/$username/.fonts/*
fc-cache -vf
rm ./JetBrainsMono.zip

# TPM
git clone https://github.com/tmux-plugins/tpm /home/$username/.tmux/plugins/tpm

# NVCHAD
git clone https://github.com/NvChad/NvChad /home/$username/.config/nvim --depth 1

chown -R $username:$username /home/$username
