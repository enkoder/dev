export DOTFILES=$HOME/.dotfiles
export ZSH=$DOTFILES/zsh

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# display how long all tasks over 10 seconds take
export REPORTTIME=10

# define the code directory
# This is where my code exists and where I want the c autocomplete to work from exclusively
if [[ -d ~/code ]]; then
    export CODE_DIR=~/code
fi

# source all .zsh files inside of the zsh/ directory
for config ($ZSH/**/*.zsh) source $config

# source all local non-versioned content
if [[ -a ~/.localrc ]]; then
    source ~/.localrc
fi

# initialize autocomplete
autoload -U compinit
compinit
zstyle ':completion:*' menu select
zmodload zsh/complist

export PATH=/usr/local/bin:$PATH

# add /usr/local/sbin
if [[ -d /usr/local/sbin ]]; then
    export PATH=/usr/local/sbin:$PATH
fi

# add /usr/sbin
if [[ -d /usr/sbin ]]; then
    export PATH=/usr/sbin:$PATH
fi

# adding path directory for custom scripts
export PATH=$DOTFILES/bin:$PATH

# check for custom bin directory and add to path
if [[ -d ~/bin ]]; then
    export PATH=~/bin:$PATH
fi

# adds the GOPATH env
if [[ -d ~/go ]]; then
    export GOPATH=~/go
    export GOROOT=/opt/go
    export PATH=$PATH:$GOPATH/bin:$GOROOT/bin
fi


if [[ -f /home/enkoder/.local/bin/virtualenvwrapper.sh ]]; then
    source /home/enkoder/.local/bin/virtualenvwrapper.sh
fi

# sets the vim keybindings for autocomplete nav
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# Sourcing /home/enkoder/.discordrc rcfile
if [[ -f /home/enkoder/.discordrc ]]; then
   source /home/enkoder/.discordrc
fi

export GOPATH=/home/enkoder/go
export GOROOT=/usr/local/go
export PATH=$PATH:/home/enkoder/.dotfiles/bin
export PATH=$PATH:/home/enkoder/go/bin
export PATH=$PATH:/home/enkoder/.local/bin
export PATH=$PATH:/usr/local/go/bin

export GOPATH=/home/enkoder/go
export GOROOT=/usr/local/go
export PATH=$PATH:/home/enkoder/.bazel/bin

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/enkoder/google-cloud-sdk/path.zsh.inc' ]; then source '/home/enkoder/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/enkoder/google-cloud-sdk/completion.zsh.inc' ]; then source '/home/enkoder/google-cloud-sdk/completion.zsh.inc'; fi

if [[ -f /usr/local/bin/virtualenvwrapper.sh ]]; then source /usr/local/bin/virtualenvwrapper.sh; fi

# Sourcing discordrc
if [[ -f "~/.discordrc" ]]; then source ~/.discordrc; fi
