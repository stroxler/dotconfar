# git-prompt -----------------------------------------
#
# adapted from https://gist.github.com/michaelneu/943693f46f7aa249fad2e6841cd918d5

function git-prompt() {
  branch_name=$(git symbolic-ref -q HEAD 2>/dev/null)
  if [ $? == 0 ]; then
    branch_name=${branch_name##refs/heads/}
    branch_name=${branch_name:-HEAD}

    echo -n "→ "

    if [[ $(git status 2> /dev/null | tail -n1) = *"nothing to commit"* ]]; then
      echo -n "$COLOR_GIT_CLEAN$branch_name$COLOR_RESET"
    elif [[ $(git status 2> /dev/null | head -n5) = *"Changes to be committed"* ]]; then
      echo -n "$COLOR_GIT_STAGED$branch_name$COLOR_RESET"
    else
      echo -n "$COLOR_GIT_MODIFIED$branch_name*$COLOR_RESET"
    fi

    echo -n " "
  fi
}
# 

# git-log ------------------------------------

function git-log() {
  git log --oneline --decorate -n 15
}

# git-status ---------------------------------
#
# Adapted from https://coderwall.com/p/ewz5zq

function _unstaged_changes() {
    worktree=${1%/*};
    git --git-dir="$1" --work-tree="$worktree" diff-files --quiet \
        --ignore-submodules --
}

function _uncommited_changes() {
    worktree=${1%/*};
    git --git-dir="$1" --work-tree="$worktree" diff-index --cached --quiet \
        HEAD --ignore-submodules --
}

function _untracked() {
    worktree=${1%/*};
    git --git-dir="$1" --work-tree="$worktree" ls-files --other \
        --exclude-standard --error-unmatch . >/dev/null 2>&1
}

function git-status() {
    for gitdir in `find . -name .git`;
    do
        worktree=${gitdir%/*};
        if (! unstaged_changes $gitdir) || (! uncommited_changes $gitdir) \
           || (untracked $gitdir = 0)
        then
            echo "=== $gitdir ==="
            git --git-dir=$gitdir --work-tree="$worktree" status -s
        fi
    done
}

