# Load the zgen plugin manager
if ! [[ -f "${HOME}/.zgen/zgen.zsh" ]]; then
	echo "No zgen available - skipping plugins"
else
	source "${HOME}/.zgen/zgen.zsh"

	if ! zgen saved; then
		zgen oh-my-zsh
		zgen oh-my-zsh plugins/git
		zgen oh-my-zsh plugins/command-not-found
		zgen load zsh-users/zsh-syntax-highlighting

		## An advantage of zgen is I can also use prezto if I want:
		# zgen prezto
		# zgen prezto <modulename>

		zgen save
	fi
fi

# Load starship.rs prompt
if [[ -z $(which starship 2>/dev/null ) ]]; then
	echo "No starship.rs installed, not loading prompt"
else
	eval $(starship init zsh)
fi

# Load all the environments that are cross-shell
for script_to_source in ~/.config/xsh/*; do
  source "$script_to_source"
done
