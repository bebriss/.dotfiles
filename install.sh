#!/bin/bash

# Check if Script is Run as Root
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script, please run sudo ./install.sh" 2>&1
  exit 1
fi

username=$(id -u -n 1000)
builddir=$(pwd)

# Update packages list and update system
apt update
apt upgrade -y

# Making .config and Moving config files and background to Pictures
cd $builddir
mkdir -p /home/$username/.config
mkdir -p /home/$username/.fonts
mkdir -p /home/$username/Pictures
mkdir -p /home/$username/Pictures/backgrounds
cp bg.jpg /home/$username/Pictures/backgrounds/
chown -R $username:$username /home/$username

# Installing Essential Programs 
apt install i3-wm feh alacritty rofi pulseaudio pavucontrol build-essential neovim lightdm -y 
apt install maim xclip picom thunar unzip wget gh stow -y 

# Installing fonts
cd $builddir 
apt install fonts-jetbrains-mono -y 
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip
unzip JetBrainsMono.zip -d /home/$username/.fonts
chown $username:$username /home/$username/.fonts/*

# Reloading Font
fc-cache -vf
# Removing zip Files
rm ./JetBrainsMono.zip

# NvChad
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1

# Enable graphical login and change target from CLI to GUI
systemctl enable lightdm
systemctl set-default graphical.target

# stow
cd $builddir
stow ./*
stow .zshrc

