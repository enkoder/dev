#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
#compdef clid
_clid() {
  eval $(env COMMANDLINE="${words[1,$CURRENT]}" _CLID_COMPLETE=complete-zsh  clid)
}
if [[ "$(basename -- ${(%):-%x})" != "_clid" ]]; then
  compdef _clid clid
fi
