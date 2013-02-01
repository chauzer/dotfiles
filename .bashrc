# sourced on new screens, non-login shells.
#echo sourcing .bashrc

host=`uname -n | sed -e 's/\.local//g'`;
uname=`uname`;

if [ "$host" == "asterix" ]; then
    export FLEX_HOME='/Applications/Adobe Flash Builder 4/sdks/3.5.0.12683B'
    export RSL_VERSION=3.5.0.21474
    export CATALINA_HOME='/Users/norton/dev/tomcat6'

    [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

    alias jj='autojump'

    alias sleep='gsleep'
    alias find='/opt/local/bin/gfind'
    alias jj='autojump'

    # use 1.8.1 ant
    alias ant='/usr/local/bin/ant'
    alias best='ant test 1> /dev/null/'
    alias dbc='cd "$(find $HOME/dev/dbc/ -name `date '+%Y%m%d'`)"'

fi

if [ "$uname" == "Darwin" ]; then
    if [ -f /opt/local/etc/profile.d/autojump.sh ]; then
        . /opt/local/etc/profile.d/autojump.sh
    fi

    if [ -f /opt/local/etc/bash_completion ]; then
        . /opt/local/etc/bash_completion
    fi


    export EDITNOW='subl'
    export EDITOR='subl -w'

    export LESS="$LESS -i -F -R -X"
    # set java home
    export JAVA_HOME=/Library/Java/Home
    # preview man
    pman() {
        man -t "${1}" | open -f -a /Applications/Preview.app/
    }
    # use BSD ls with no --color
    alias ls='ls -F'
elif [ "$uname" == "Linux" ]; then
    # use GNU ls with --color
    alias ls='ls --color -F'
    alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

    export EDITNOW='vim'
    export EDITOR='vim'

    if [ -f ~/.bash_aliases ]; then
        . ~/.bash_aliases
    fi

    if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
        . /etc/bash_completion
    fi
fi

export CLICOLOR=1
export TERM=xterm-color
export HISTCONTROL="ignoredups"
export HISTIGNORE="[   ]*:&:bg:fg:exit"

# do close spelling matches with cd
shopt -s cdspell
shopt -s histappend
shopt -s nocaseglob
shopt -s checkwinsize

# handy aliases
alias ll='ls -l'
alias la='ls -hlA'
alias l='ls'
alias df='df -h'
alias du='du -h'
alias top='top -o cpu'
alias grep="grep --color"


alias hosts='sudo $EDITNOW /etc/hosts'
alias pjs='sudo jps -mlvV | grep -v "Bootstrap\|Jps\|\/opt\/dell\/srvadmin"'

# fun aliases
alias wtc='curl -s "http://whatthecommit.com" | grep "<p>" | cut -c4-'
alias scg='curl -s http://www.madsci.org/cgi-bin/cgiwrap/~lynn/jardin/SCG | grep "<h2>" -A4 | tr "\n" " " | sed -e "s/<h2>[ \t]*//" -e "s/\<.*$//g"'
alias prpg="LC_CTYPE=C tr -dc 'A-Za-z0-9!@#$%^&*' < /dev/urandom | fold -w 18 | head -n1"

#aliases for my local stuff
alias ddate="date '+%Y%m%d%'"
alias mdate="date '+%Y-%m-%d%'"
alias cdate="date '+%Y%m%d%H%M%S'"
#osx - open an application and force a new instance even if there's one already running
alias opena="open -n -a"

parse_git_branch() {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

uber_prompt() {
    local        BLUE="\[\033[0;34m\]"
    local      YELLOW="\[\033[0;33m\]"
    local         RED="\[\033[0;31m\]"
    local   LIGHT_RED="\[\033[1;31m\]"
    local       GREEN="\[\033[0;32m\]"
    local LIGHT_GREEN="\[\033[1;32m\]"
    local       WHITE="\[\033[1;37m\]"
    local  LIGHT_GRAY="\[\033[0;37m\]"

    PS1="$LIGHT_GRAY\u@\h:\W$GREEN\$(parse_git_branch)$LIGHT_GRAY\$ "
    PS2='> '
    PS4='+ '
}

uber_prompt

# if there are settings for a particular machine, put them in .local.bashrc
# i.e. PS1="[\u@\h \W]\$ "
if [ -f $HOME/.local.bashrc ]; then
    echo "Sourcing $HOME/.local.bashrc"
    . $HOME/.local.bashrc
fi
