source $HOME/.aliases
export GOPATH="$HOME/golang"
export PATH=$HOME/.rvm/gems/ruby-2.1.0/bin:$HOME/bin:$HOME/Documents/pebble-dev/PebbleSDK-2.0-BETA3/bin:/usr/local/bin:$HOME/.rvm/bin:/usr/local/heroku/bin:$HOME/go_appengine:$HOME/golang/bin:/usr/local/sbin:$PATH

if [ -f $(brew --prefix)/etc/bash_completion ]; then
    source $(brew --prefix)/etc/bash_completion
fi

export WORKON_HOME=$HOME/.venvs/
export PROJECT_HOME=$HOME/Documents/
export PIP_REQUIRE_VIRTUALENV=true
export PIP_DOWNLOAD_CACHE=$HOME/.pip/cache

syspip(){
    PIP_REQUIRE_VIRTUALENV="" pip "$@"
}

reap(){
    sudo cp -r /Users/sfishman_old/"$@" ~/"$@"
    sudo chown -R sfishman ~/"$@"
}

gostart(){
    if [ -z "$1" ]; then
        echo "Provide project name!"
    fi

    full_proj_path="$GOPATH/src/github.com/samfishman/$1"
    mkdir -p "$full_proj_path"
    ln -s "$full_proj_path" "$1"
    cd "$1"
}

godel(){
    if [ -z "$1" ]; then
        echo "Provide project name!"
    fi

    full_proj_path="$GOPATH/src/github.com/samfishman/$1"
    del "$fullprojpath"
    del "$1"
}

# export PATH=$PATH:/usr/local/opt/ruby/bin
source "/usr/local/bin/virtualenvwrapper.sh"

# source ~/etc/activate-completion.bash
source ~/etc/git-completion.bash
source ~/etc/django_bash_completion.sh

# export GITAWAREPROMPT=~/.bash/git-aware-prompt
# source $GITAWAREPROMPT/main.sh
# export PS1="\u@\h \w \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\$ "

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" 

export PYTHONSTARTUP="$HOME/.pyrc"
export EDITOR="vim"

# Initialization for FDK command line tools.Thu Jun 26 10:38:36 2014
export FDK_EXE="/Users/sfishman/bin/FDK/Tools/osx"
export PATH=${PATH}:"/Users/sfishman/bin/FDK/Tools/osx"

export TEXINPUTS="$TEXINPUTS:$HOME/Dropbox/Classes/CS121/Homework"


# Pebble SDK
export PATH="/Users/sfishman/pebble-dev/PebbleSDK-current/bin:$PATH"

# OPAM configuration
. /Users/sfishman/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

# VMWare utility (vmrun)
export PATH="$PATH:/Applications/VMware Fusion.app/Contents/Library"

# CS50 VM
path161="/Users/sfishman/Documents/Virtual Machines.localized/appliance50-fishman-cs161.vmwarevm/"
vmrun="vmrun -T fusion -gu jharvard -gp crimson"
ip161(){
    # TODO: get this to work
    # $vmrun getGuestIPAddress "$path161"
    echo 172.16.29.128
}
addr161(){
    echo jharvard@$(ip161)
}
cs161(){
    if [ $# -eq 0 ]; then
        local command=connect
    else
        local command=$1
    fi


    if [ $command == "connect" ]; then
        local running=$(vmrun list)
        echo "$running" | grep "$path161" &> /dev/null

        if [ $? -eq 1 ]; then
            $vmrun start "$path161" nogui > /dev/null
            local status=$?
            if [ $status -eq 0 ]; then
                echo "started VM, waiting for SSH"
                sleep 8
            else
                echo "ERROR STARTING VM"
                exit $status
            fi
        else
            echo "VM already running, connecting via SSH"
        fi

        ssh jharvard@$(ip161)
        while [ $? -eq 255 ]; do
            sleep 1
            ssh jharvard@$(ip161)
        done
    elif [ $command == "start" -a -z "$2" ]; then
        $vmrun $command "$path161" nogui
    else
        $vmrun $command "$path161" ${@:2}
    fi
}
