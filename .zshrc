# Inspired by Luke's config for the Zoomer Shell

# verbosity and command settings 
alias \
	cp='cp -iv' \
	mv='mv -iv' \
	rm='rm -vI' \
	mkdir='mkdir -pv' \
	ls='ls -hN --color=auto --group-directories-first' \
	ll='ls -lah --color=auto'

# shortcuts
alias \
  python=python3 \
  pip=pip3 \
  sus='sleep 1 && systemctl suspend' \
  nv='nvim' \
  cf='tmux new-window -c ~/.dotfiles' \
  cfrr='tmux new-window "cd ~/.dotfiles && ./config.sh"' \
  cfzs='nvim ~/.dotfiles/.zshrc' \
  cfi3='nvim ~/.dotfiles/.config/i3/config' \
  cfal='nvim ~/.dotfiles/.config/alacritty/alacritty.toml'

# history cache / size
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v

# autocomplete 
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

# cd through ranger
rangercd () {
    tmp="$(mktemp)"
    ranger --choosedir="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'rangercd\n'

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line
