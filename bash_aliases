alias cr="cd ~/Documents/crimson/crimsononline; workon crim"
alias chr="open -a /Applications/Google\ Chrome.app"
alias del="rmtrash"
alias vmi="vim"
alias ls="ls -G"
alias ll="ls -al"
alias gs="git status"
alias clera="clear"

# port forwarding
alias fwd="sudo ipfw add 100 fwd 127.0.0.1,8000 tcp from any to any 80 in"
alias phttp="python -m SimpleHTTPServer"

alias gen="workon general"

alias gonode=". ~/.venvs/nodestable/bin/activate"

alias ck=". ~/.venvs/nodestable/bin/activate && rvm gemset use cork && cd ~/Documents/projects/cork"

alias vag="vagrant"
alias vagup="vagrant up"
alias vagha="vagrant halt"