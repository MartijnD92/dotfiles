# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Load other dotfiles
for file in ~/.{aliases,functions,exports}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Use VIM keybindings in terminal
set -o vi

autoload -U colors && colors
PS1="[%*] %{$fg[green]%}%n %{$fg[yellow]%}%(5~|%-1~/.../%3~|%4~) %{$fg[red]%}$ %{$reset_color%}%\ "

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
