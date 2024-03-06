# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Use VIM keybindings in terminal
set -o vi

count() {
  if [ "$1" = "-c" ]
  then
    printf "$2" | wc -c
  elif [ "$1" = "-w" ]
  then
    printf "$2" | wc -w
  fi
}

newpass() {
    date +%s | sha256sum | base64 | head -c 32 ; echo
}

export JAVA_HOME=$(/usr/libexec/java_home)

setopt HIST_IGNORE_ALL_DUPS

# ALIASES
alias md="mkdir"
alias st="speedtest-cli"
alias diff="diff -u --color"
alias v="lvim"
alias cl="clear"
alias py="python3"
alias zsh="v ~/.zshrc"
# Trim new lines and copy to clipboard
alias c="tr -d '\n' | pbcopy"
# URL-encode strings
alias urlencode='python3 -c "import sys, urllib.parse as ul; print(ul.quote_plus(sys.argv[1]));"'

autoload -U colors && colors
PS1="[%*] %{$fg[green]%}%n %{$fg[yellow]%}%(5~|%-1~/.../%3~|%4~) %{$fg[red]%}$ %{$reset_color%}%\ "

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# History management
export HISTCONTROL=ignoreboth
export HISTSIZE=5000
export HISTIGNORE="clear:bg:fg:cd:cd -:cd ..:exit:date:w:* --help:ls:l:ll:lll"


load-nvmrc() {
    local node_version="$(nvm version)"
    local nvmrc_path="$(nvm_find_nvmrc)"

    if [ -n "$nvmrc_path" ]; then
        local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

        if [ "$nvmrc_node_version" = "N/A" ]; then
        nvm install
        elif [ "$nvmrc_node_version" != "$node_version" ]; then
        nvm use
        fi
    elif [ "$node_version" != "$(nvm version default)" ]; then
        nvm use default
    fi
}

if [ -s "$HOME/.nvm/nvm.sh" ]; then
    export NVM_DIR="$HOME/.nvm"
    nvm_cmds=(nvm node npm yarn gulp)
    for cmd in "${nvm_cmds[@]}" ; do
        alias $cmd="echo \"'nvm' loading... It's super slow, hold onto your hat...\" && unalias ${nvm_cmds[*]} && unset nvm_cmds && . $NVM_DIR/nvm.sh --no-use && load-nvmrc && $cmd"
    done
fi

# Add Lunarvim to path
export PATH="$HOME/.local/bin:$PATH"
