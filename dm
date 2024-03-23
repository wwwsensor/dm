#!/bin/sh
# WWW          : https://github.com/wwwsensor/dm
# Author       : @sensor @ss
# Dependencies : git

# Notable variables
N=/dev/null
URL=https://raw.githubusercontent.com/wwwsensor/dm/master

# Handle errors
senderr(){ echo dm: "$@";exit 1; }

# Functions
usage()
{
cat - >&2 <<EOF

 Dotfiles Manager: Deploy a Git repo to \$HOME

  dm <repo>  Deploy a repo
  dm a       Print Git aliases
  dm         Get help
  gx         Get aliases help

EOF
}

aliases()
{
cat - >&2 <<EOF
alias g="git"
alias gx="grep '=\"g' $ZDOTDIR/.zshrc | sed -e 's/a //g'"
alias gg="g commit -m 'Update' && g push"
alias grm="g rm --cached"
alias gco="g commit"
alias gr="g restore"
alias gre="g reset"
alias gcl="g clone"
alias gs="g status"
alias gpu="g push"
alias gd="g diff"
alias ga="g add"
EOF
}

main()
{
  # Handle dependencies
  which git >$N || senderr git not found

  # Error if there is a repo in $HOME
  [ -d ~/.git ] && senderr ~/.git: There is a repo

  # Make a temp dir
  DIR=$(mktemp -d) &&

  # Clone repo there
  git clone $1 $DIR &&

  # Move contents to $HOME
  cp -rf $DIR/.[!.]* ~ &&

  # Configure repo to hide untracked files
  git config -f ~/.git/config status.showUntrackedFiles no
}

# Flow
case $1 in
  "") usage ;;
  a) aliases ;;
  *) main $1 ;;
esac
