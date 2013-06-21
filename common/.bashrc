# on MAC OS X
#alias ls='ls -G'
alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -al'

alias grep='grep -i --color'
alias egrep='egrep --color'

#on MAC OS X , set PS1
PS1="[\u@\h \[$(tput setaf 2)\]\W\[$(tput sgr0)\]] $ "
LANG="en_US.UTF-8"
#PATH=/Users/veizz/bin:$PATH
