# Latest notes on neovim

I've recently started using LazyVim (the starter kit from
the author of the lazy.vim plugin manager) as a starter kit.

There are quite a few things that don't work well for me
out of the box; the one I fixed so far is autocomplete - it
defaults to using `<Enter>` which drives me nuts.

Just noting the fix for this here:

I injected an override of the default lazyvim completion into
`~/.config/nvim/lua/plugins/cmp.lua`:
```lua
CAT > ~/.config/nvim/lua/plugins/cmp.lua <<\EOF_CMP
-- This is the default config listed at
-- https://www.lazyvim.org/plugins/coding#nvim-cmp (as of Nov 1 2023),
-- except that I've changed the confirm to <Tab>
return {
  "hrsh7th/nvim-cmp",
  version = false, -- last release is way too old
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "saadparwaiz1/cmp_luasnip",
  },
  opts = function()
    vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
    local cmp = require("cmp")
    local defaults = require("cmp.config.default")()
    return {
      completion = {
        completeopt = "menu,menuone,noinsert",
      },
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<Tab>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<S-CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<C-CR>"] = function(fallback)
          cmp.abort()
          fallback()
        end,
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "path" },
      }, {
        { name = "buffer" },
      }),
      formatting = {
        format = function(_, item)
          local icons = require("lazyvim.config").icons.kinds
          if icons[item.kind] then
            item.kind = icons[item.kind] .. item.kind
          end
          return item
        end,
      },
      experimental = {
        ghost_text = {
          hl_group = "CmpGhostText",
        },
      },
      sorting = defaults.sorting,
    }
  end,
  ---@param opts cmp.ConfigSchema
  config = function(_, opts)
    for _, source in ipairs(opts.sources) do
      source.group_index = source.group_index or 1
    end
    require("cmp").setup(opts)
  end,
}
EOF_CMP
```

You can 


# Older notes on neovim

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
    "talha-akram/noctis.nvim"
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "stellarized",
    },
  },
}
```

These are probably the color themes I'd want regardless - in particular I think
the `solarized8_low`, `everforest`, and `stellarized` themes are really nice,
and they aren't available for terminal or emacs which makes them particularly
good choices for neovim.

The noctis themes are also quite nice, the colors are the same as in vscode but
the actual expression on code is pretty different due to different syntax ->
color rules (this is the same reason why I usually like solarized and zenburn
more in emacs than vim, even though the actual pallet is identical).

Stllrzd is nice but I think I prefer stellarized, especially since stllrzd is
available in iterm. And nord and gruvbox are available everywhere.
