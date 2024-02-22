#!/bin/sh
# WWW          : https://github.com/wwwsensor/dm
# Author       : @sensor @ss
# Dependencies : git curl

# Handle errors
senderr(){ echo dm: "$@";exit 1; }

# Handle dependencies
for d in git curl; do
  which $d >/dev/null || senderr $d not found
done

# Print README if no arguments
[ -z $@ ] && { curl -L https://raw.githubusercontent.com/wwwsensor/dm/master/README; exit; }

# Error if there is a repo in $HOME
[ -d ~/.git ] && senderr ~/.git: There is a repo

# Main
## Make a temp dir
dir=$(mktemp -d) &&
## Clone repo there
git clone $1 $dir &&
## Move contents to $HOME
mv -f $dir/.[!.]* ~ &&
## Configure repo to hide untracked files
git config -f .git/config status.showUntrackedFiles no
