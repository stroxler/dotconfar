# Notes on neovim

I'm still not sure how I want to set up vim, but I am
leaning toward trying some starter kit.

I've looked at a few, they are all pretty similar to be honest
(more so than emacs starter kits); I'm leaning toward LazyVim
for now because it seems a little lighter-weight than the
dominant Nvchad is right now, plus it's by the lazy.vim author
who obviously knows a lot about neovim :)

I haven't done any customizations yet other than color themes. To
grab the color themes I want, you can set up some files in
~/.config/nvim/lua/plugins/ as follows

~/.config/nvim/lua/plugins/trox-theme-collection.lua:
```lua
return {
  {
    "thekelvinliu/stllrzd",
  },
  {
    "tsax/stellarized",
  },
  {
    "lifepillar/vim-solarized8",
  },
  {
    "sainnhe/everforest",
  },
  {
    "morhetz/gruvbox",
  },
  {
    "nordtheme/vim",
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "stellarized",
    },
  },
}
```

These are probably the color themes I'd want regardless - in particular
I think the `solarized8_low` and `stellarized` themes are really nice, and
they aren't available for terminal or emacs which makes them particularly
good choices for neovim (since I like to use different themes everywhere).
