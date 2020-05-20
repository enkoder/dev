alias pacup="yaourt -Syua --noconfirm"
alias gr="cd '$(git rev-parse --show-toplevel)'"
alias c="cd $CODE_DIR"
alias gf="git fetch --prune --tags"
alias gbc='git branch --merged | grep -v "\*" | grep -v master | grep -v develop | grep -v release | xargs -n 1 git branch -d && git remote prune origin'
alias diclean='docker rmi -f $(docker images | grep "<none>" | awk "{print \$3}")'
alias dclean='docker rm $(docker ps -a -q)'
alias dc='docker-compose'
