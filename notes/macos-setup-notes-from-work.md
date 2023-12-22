# Macos Setup for Work

## Intro 

I have somewhat detailed instructions for setting up a corp-owned mac laptop.

I've decided to go ahead and put them in my dotconfar since the vast majority
of the steps here are not specific to work; the only things I think are really
work specific are:
- The use of corp-managed "VSCode" rather than "Visual Studio Code"
  - By extension, there are a lot of packages I would want in Visual Studio Code
    that get automatically added (or internal equivalents are added) by the
    corp-managed install
- The use of managed software central rather than just a brew cask install or
  gui pkg download for some apps, in particular iterm2.

## Instructions

Go to managed software central to install VSCode and iTerm.

In system settings -> accessibility:
- [turn on three-finger drag](https://support.apple.com/en-us/HT204609)
- make the pointer a bit bigger (helps with 2-monitor setups)

In system settings -> keyboard -> keyboard shortcuts -> modifier keys, select the relevant keyboards and make any switches needed (e.g. command vs option for my Arteck keyboard at home).

In system settings -> keyboard -> dictation, switch the shortcut to "Right Command Key Twice" (default is control key twice, which I do by accident all the time).

Under settings -> desktop & dock -> mission control, unselect "Displays have separate spaces", and also unselect "Automatically rearrange Spaces...".

In iterm profile settings:
- for default:
  - solarized light
  - in keys, make sure left option is set to Esc+
- for tmux (it will only exist after you et + tmux -CC):
  - solarized dark
  - in keys, make sure left option is set to Esc+

In chrome, get the fburl plugin installed and "pin" it to the UI

In VSCode, install these plugins:
- indent-rainbow
- vim
- noctis
- Rusty Theme (good for ocaml, iffy for others)
- solarized minimal (better for python than the built-in one)
- also consider setting up an custom theme for ondemand:
  - https://fburl.com/workplace/u9lkqfk6
  - this is handy for keeping context if you mix devserver vs ondemand


Install starship. Apparently updates can break nix (probably admin user futzing with things on my corp laptop) so it's nice to make sure basic shell scripts don't crap out:
```
curl -sS https://starship.rs/install.sh | sh
```

Do a nix-env install for cli tools, I don't like brew. By far the single most important tool is going to be `et`... between that and vscode I have about 75% of what I need to be productive. I'm using nix purely as a brew alternative for now, not hooking into any of it's real power :/
```
nix-env -iA \
  nixpkgs.eternal-terminal \
  nixpkgs.mosh \
  nixpkgs.stack \
  nixpkgs.neovim \
  nixpkgs.opam \
  nixpkgs.rustup \
  nixpkgs.cmake \
  nixpkgs.tree \
  nixpkgs.ripgrep \
  nixpkgs.fish
```

Nix has far fewer ownership issues than homebrew, but you still may periodically have to reset ownership of your nix lockfile (I think some IT chef process probably sets it to root):
```
sudo chown -R $USER /nix/var/nix/profiles/per-user/$USER/
```


Do a brew install just to get casks. Currently the ones I think I need to be reasonably productive:
```
brew install --cask emacs clipy rectangle flux firefox spotify vagrant
```

Do my local setup, borrowed from devserver:
```
stack path

echo "
nix:
  enable: true
" >> ~/.stack/config.yaml

cd ~/confar-v0 \
  && stack build \
  && stack install
```
and then
```
cd ~/dotconfar \
  && rm -rf ~/.emacs ~/.inputrc ~/.gitconfig ~/.doom.d \
  && PATH=$PATH:~/.local/bin/ bash run-confar.sh \
  && bash bash/initialize-env.sh \
  && echo -e "\n---- success installing dotconfar! ----\n" \
  || echo -e "\n---- ERROR installing dotconfar :( ----\n"
```

In Firefox, install password manager + ublock origin.

## Bootstrap some language multi-env tools

If I ever move to full nix I won't need these, but for now I do need them...

Nvm and node:
```
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

nvm install node
```

Pyenv:
```
curl https://pyenv.run | bash

pyenv install 3.11.3
```


## Dev env things I still need to accomplish / learn / relearn

- Give zsh another try [so post with some good info](https://apple.stackexchange.com/questions/361870/what-are-the-practical-differences-between-bash-and-zsh)
- Figure out a setup to use for scripting in devserver
  - It can just be a set of standard scripts and aliases / commands,
    the key thing is to just stop copying and modifying commands
    painstakingly by hand.
- Learn the basics of nix flakes; maybe try out cachix and devenv(?)
- Try emacs and neovim again - in particular:
  - Get org mode going again for work notes
  - Get emacs working on devserver (less important now than it was)
- Learn about direnv and its competitors

## Key things to be able to run


```
# this is supposedly the new cc-certs
kdestroy && kinit && fb-sks-agent renew
```


## Some other notes

I want to be able to study on my own locally, and some of the material I want to go through is best done in linux. As a result Vagrant + VirtualBox is handy.


You can easily `brew install --cask vagrant`

VirtualBox for M1 is pretty new, you can get it from the downloads page at https://www.virtualbox.org/wiki/Downloads

At some point I'll probably want to look at the more low-level https://www.qemu.org/, which seems to be the standard way to study operating-system level stuff these days.
