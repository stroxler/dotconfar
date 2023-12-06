# My dotconfar

I built a tool `confar-v0` to let me spread out various dotfiles in a way that
I can make sense of. The tool works pretty well for setting up my dotfiles,
although it doesn't check enough state to detect collisions or clean up old
files.

If you have `confar-v0` already installed, then you can sync files from
dotconfar by just running the `run-confar.sh` script, which will sync
each grouping of dotfiles here into `$HOME`.

This whole setup is pretty janky, it works for me but I wouldn't recommend
it; there are tools that can do similar things managing state more clearly
(in particular, I'm hoping to eventually investigate nix which I believe
can be leveraged for managing dotfiles).

# Layout

It's split out loosely by tool - e.g. shell vs editor.

I've also got some markdown notes in `notes` about various setups that I
haven't yet translated into my dotconfar; for example my neovim config
is not currently confar-managed.
