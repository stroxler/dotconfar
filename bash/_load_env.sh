#!/usr/bin/env/bash

# load my standard environment
for env_script in ~/_env/*; do
  . "$env_script"
done

# load my local environment if any
if [ -d ~/_local_env ]; then
  for env_script in ~/_local_env/*; do
    . "$env_script"
  done
fi

# path mangling
export PATH="${HOME}/bin:${HOME}/.local/bin:$PATH"

# set the prompt
GIT_PS1='\[\033[0;34m\]${debian_chroot:+($debian_chroot)}\u@\h\[\033[33m\] : \w`git-prompt`\n>\[\033[00m\] '
NOGIT_PS1='\[\033[0;34m\]${debian_chroot:+($debian_chroot)}\u@\h\[\033[33m\] : \w\n>\[\033[00m\] '

function git-prompt-on() {
  export PS1=$GIT_PS1
}
function git-prompt-off() {
  export PS1=$NOGIT_PS1
}
git-prompt-on
