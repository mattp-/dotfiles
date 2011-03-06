# .bashrc

# User specific aliases and functions

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

if [ -f ~/.localbashrc ]; then
    . ~/.localbashrc
fi

if [ -f /home/`whoami`/perl5/perlbrew/etc/bashrc ]; then
    . /home/`whoami`/perl5/perlbrew/etc/bashrc
fi

RED="\[\033[0;31m\]"
YELLOW="\[\033[0;33m\]"
GREEN="\[\033[0;32m\]"
BLUE="\[\033[0;34m\]"
LIGHT_RED="\[\033[0;31m\]"
LIGHT_GREEN="\[\033[0;32m\]"
WHITE="\[\033[0;37m\]"
WHITE='\e[0;37m'
LIGHT_GRAY="\[\033[0;37m\]"
COLOR_NONE="\[\e[0m\]"

function parse_git_branch {

  git rev-parse --git-dir &> /dev/null
  git_status="$(git status 2> /dev/null)"
  branch_pattern="^# On branch ([^${IFS}]*)"
  remote_pattern="# Your branch is (.*) of"
  diverge_pattern="# Your branch and (.*) have diverged"
  if [[ ! ${git_status} =~ "working directory clean" ]]; then
    state=""
  fi
  # add an else if or two here if you want to get more specific
  if [[ ${git_status} =~ ${remote_pattern} ]]; then
    if [[ ${BASH_REMATCH[1]} == "ahead" ]]; then
      remote="${YELLOW}↑"
    else
      remote="${YELLOW}↓"
    fi
  fi
  if [[ ${git_status} =~ ${diverge_pattern} ]]; then
    remote="${YELLOW}↕"
  fi
  if [[ ${git_status} =~ ${branch_pattern} ]]; then
    branch=${BASH_REMATCH[1]}
    echo " (${branch})${remote}${state}"
  fi
}

function prompt_func() {
    HOSTNAME=`hostname`
    case $HOSTNAME in
        "escher") SHELL_COLOR=$YELLOW ;;
        "bach") SHELL_COLOR=$LIGHT_GREEN ;;
        "dell") SHELL_COLOR=$RED ;;
        "bacchus") SHELL_COLOR=$BLUE ;;
    esac

    previous_return_value=$?;
    # prompt="${TITLEBAR}$BLUE[$RED\w$GREEN$(__git_ps1)$YELLOW$(git_dirty_flag)$BLUE]$COLOR_NONE "
    prompt="${TITLEBAR}${SHELL_COLOR}[${COLOR_NONE}\w${LIGHT_GRAY}$(parse_git_branch)${SHELL_COLOR}]${COLOR_NONE} "
    if test $previous_return_value -eq 0
    then
        PS1="${prompt}$ "
    else
        PS1="${prompt}${RED}${COLOR_NONE}$ "
    fi
}

PROMPT_COMMAND=prompt_func

#eval $(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)
#alias gcc='gcc -Wall -Wstrict-prototypes -ansi -pedantic -g'
alias ls='ls --color'

set -o vi

LESS=-r
AWT_TOOLKIT="MToolkit"
IPOD_MOUNTPOINT='/mnt/ipod'
TERM=xterm-256color
PATH=/opt/thunderbird:$PATH
#LANG=C
LANG=en_US.utf8
EDITOR=vim
export "PERL_RL= o=0"         # Use best available ReadLine without ornaments

