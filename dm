#!/bin/sh
# WWW          : https://github.com/wwwsensor/dm
# Author       : @sensor @ss
# Dependencies : curl git

# Common variables
N=/dev/null
URL=https://raw.githubusercontent.com/wwwsensor/dm/master

# Handle errors
senderr(){ echo dm: "$@";exit 1; }

aliases(){ curl -s $URL/aliases; }
main(){
  # Error if there is a repo in $HOME
  [ -d ~/.git ] && senderr ~/.git: There is a repo

  # Handle dependencies
  which curl >$N || senderr curl not found
  which git >$N || senderr git not found

  # Make a temp dir
  DIR=$(mktemp -d) &&

  # Clone repo there
  git clone $1 $DIR &&

  # Move contents to $HOME
  mv -f $DIR/.[!.]* ~ &&

  # Configure repo to hide untracked files
  git config -f ~/.git/config status.showUntrackedFiles no
}

# Script flow
case $1 in
  "") curl -s $URL/README; exit;;
  a) aliases;;
  *) main $1;;
esac
