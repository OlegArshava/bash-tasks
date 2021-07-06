#!/bin/bash

#color constans

COLOR_RED='\033[1;91m'
COLOR_GREEN='\033[1;32m'

#check run script as root
if [ `whoami` != 'root' ]; then
     echo "You must be root"
     exit
fi

function userExist() {
    if grep -q "^$1:" /etc/passwd; then
          printf "${COLOR_GREEN}User $1 is exist\n"
    else
          printf "${COLOR_RED}User $1 doesn't exist. This script is closed\nplace try again and enter correct user name\n"
          exit 
    fi
}

function checkDir() {
    if [ -d "$1" ]; then
          printf "${COLOR_GREEN}This directory is exist\n"
    else
          printf "${COLOR_RED}This directory doesn't exist. Place try again and enter cprrect path to directory\n"
          exit
    fi
}

function changeOwner() {
     chown -R $1:$1 "$2"
     printf "${COLOR_GREEN}changed owner directory,files and subdirectory was successful\n"
}

user=$1
dir=$2
userExist $user 
checkDir $dir
changeOwner $user $dir



