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
  cfr='tmux new-window "cd ~/.dotfiles && ./config.sh"' \
  cfzs='nvim ~/.dotfiles/.zshrc' \
  cfi3='nvim ~/.dotfiles/.config/i3/config' \
  cfal='nvim ~/.dotfiles/.config/alacritty/alacritty.toml'

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

# autocomplete 
autoload -U compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # case-insensitive tab completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}" # color tab completion
zmodload zsh/complist
compinit
_comp_options+=(globdots) # Include hidden files in tab completion

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Enable colors and change prompt:
autoload -U colors && colors	# Load colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
setopt autocd		# Automatically cd into typed directory.
stty stop undef		# Disable ctrl-s to freeze terminal.
setopt interactive_comments

# history cache / size
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v

 


