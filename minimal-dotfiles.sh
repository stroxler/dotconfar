 #!/usr/bin/env sh

# Bootstrap a minimal acceptable bash + nvim environment with no dependencies.
#
# Unlike the rest of my dotconfar, which has the config I would actually use
# on a computer I own (either a new workstation or a personal remote server),
# this is intended to be a near-instant setup that will make me minimally
# comfortable on any server I ssh into.
#
# It's intended to be easy to paste into a session.

### .inputrc ###

cat >> ~/.inputrc <<\INPUTRC_EOF

# these are what make the up and down arrow keys behave like
# c-R in a default system.
"\e[A": history-search-backward
"\e[B": history-search-forward

INPUTRC_EOF



### .bash_profile ###

cat >> ~/.bash_profile <<\BASH_PROFILE_EOF

# basic prompt support since I don't have starship
export PS1='\[\033[0;34m\]${debian_chroot:+($debian_chroot)}$(hostname)\[\033[33m\] : \w\n>\[\033[00m\] '


export EDITOR="nvim --clean '+source ~/.config/nvim/init.vim'"
alias nvim="nvim --clean '+source ~/.config/nvim/init.vim'"
alias v="nvim --clean '+source ~/.config/nvim/init.vim'"

BASH_PROFILE_EOF



### .vimrc and nvim config ###

cat > ~/.vimrc <<\VIMRC_EOF

set termguicolors
colors desert

source $LOCAL_ADMIN_SCRIPTS/master.vimrc

VIMRC_EOF


mkdir -p ~/.config/nvim

cat > ~/.config/nvim/init.vim <<\NEOVIMRC_EOF

lua << LUA_TMUX_INTEGRAION_EOF


set termguicolors
colors desert


source $LOCAL_ADMIN_SCRIPTS/master.vimrc

set termguicolors
colors desert

-- Set the initial pane to be the initial target.
--
-- Just a reminder about bare-bones tmux commands:
-- * ctl-b-% to split the window
-- * ctl-b-arrow to switch window
-- * ctl-b-[ / ctl-b-] to copy blocks of text
--
tmux_target_pane = '0'

vim.api.nvim_create_user_command('SetTmuxTarget',
  function(opts)
    local argument = opts.fargs[1]
    tmux_target_pane = argument
    print("tmux_target_pane: " .. tmux_target_pane)
  end,
  { nargs = 1 }
)

vim.api.nvim_create_user_command('LineToTmux',
  function(opts)
    local current_line = vim.api.nvim_get_current_line()
    vim.fn.system({"tmux", "send-keys", "-t", tmux_target_pane, current_line, "Enter"})
  end,
  {}
)

LUA_TMUX_INTEGRATION_EOF


map <C-t> :LineToTmux<CR>
imap <C-t> <esc>:LineToTmux<CR>a

source $LOCAL_ADMIN_SCRIPTS/master.vimrc

NEOVIMRC_EOF



### .hgrc ###

echo "nvim --clean '+source ~/.config/nvim/init.vim'" >> ~/.hgrc



### reload shell ###
exec bash -l

