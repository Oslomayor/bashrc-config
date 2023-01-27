# ========================================================================
# Date:      2023-1-27
# Author:    Denis
# Descript:  my (WLS)Ubuntu-18.04 .bsahrc
# ========================================================================
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi



# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi


export PS1="\[\033[01;31m\][\[\033[01;31m\]\t\[\033[00m\]\[\033[01;31m\]@\[\033[01;31m\]\w\[\033[00m\]\[\033[01;31m\]]\n\u->\[\033[00m\] "
# input line ERROR
# export PS1="\e[1;31m[\\u@Mars \\W \\A]\\$ \e[1;33m " 

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/root/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/root/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/root/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/root/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# activite conda environment py38
# conda activate py38
conda activate tvm
# <<< conda initialize <<<

############# my PATH #####################
# set tvm include PATH
export C_INCLUDE_PATH="${TVM_HOME}/include":${C_INCLUDE_PATH}
export CPLUS_INCLUDE_PATH="${TVM_HOME}/include":${CPLUS_INCLUDE_PATH}
export CPLUS_INCLUDE_PATH="${TVM_HOME}/3rdparty/dlpack/include":${CPLUS_INCLUDE_PATH}
export CPLUS_INCLUDE_PATH="${TVM_HOME}/3rdparty/dmlc-core/include":${CPLUS_INCLUDE_PATH}
# set arm CMSIS PATH
export CMSIS_PATH="/opt/arm/CMSIS_5-develop"
# add arm CMSIS C_INCLUDE_PATH
export C_INCLUDE_PATH="/opt/arm/CMSIS_5-develop/CMSIS/Core/Include":${C_INCLUDE_PATH}
# add arm FVP to PATH
export PATH="/opt/arm/FVP_Corstone_SSE-300/models/Linux64_GCC-6.4:${PATH}"
# add arm-gcc to PATH
export PATH="/opt/arm/gcc-arm-none-eabi/bin:${PATH}"
# add cmake 3.25 to PATH
export PATH="/opt/cmake-3.25.0-linux-x86_64/bin:$PATH"
# add llvm to PATH
export PATH="/root/tools/llvm/llvm-10.0.0/bin:$PATH"

# select tvm version
# export TVM_VERSION="v0.11.dev0"
export TVM_VERSION="v0.10.0"
# export TVM_VERSION="v0.8.0"
# set tvm PATH
export TVM_HOME=/root/tvm-$TVM_VERSION
export VTA_HW_PATH=$TVM_HOME/3rdparty/vta-hw
export PYTHONPATH=$TVM_HOME/python:${PYTHONPATH}
export PYTHONPATH=$TVM_HOME/vta/python:${PYTHONPATH}
export TVM_TRACKER_HOST=192.168.2.100

# add libtvm_runtime.so to dynamic link PATH
export LD_LIBRARY_PATH=$TVM_HOME/build:$LD_LIBRARY_PATH 
# add lib to link PATH
export LIBRARY_PATH=$TVM_HOME/build:$LIBRARY_PATH 
export LIBRARY_PATH=$TVM_HOME/build/libbacktrace:$LIBRARY_PATH 
export LIBRARY_PATH=$TVM_HOME/build/libbacktrace/lib:$LIBRARY_PATH 


############# set for PYNQ board ##########
export VTA_RPC_HOST=192.168.2.99
export VTA_RPC_PORT=9091

############# my alias #####################
alias tvm11='cd /root/tvm-v0.11.dev0;ls'
alias tvm10='cd /root/tvm-v0.10.0;ls'
alias tvm08='cd /root/tvm-v0.8.0;ls'
alias ll='ls -alF --full-time -h -t'
alias l='ls -CF'
alias v='vi ~/.bashrc'
alias s='source ~/.bashrc'
alias vvim='vi ~/.vimrc'
alias c='clear'
alias b='cd ..'
alias bb='cd ../..'
alias bbb='cd ../../..'

## alias to call sublime text ##
## subl-wsl.sh is in /bin
alias subl='subl-wsl.sh'

#alias cd=cdls
#function cdls()
#{
#    builtin cd "$1"&&ls
#}
# alias for tvmc
alias tvmc='python -m tvm.driver.tvmc'


