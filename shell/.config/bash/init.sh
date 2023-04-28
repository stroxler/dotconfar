# Load starship.rs prompt
if [[ -z $(which starship 2>/dev/null ) ]]; then
	echo "No starship.rs installed, not loading prompt"
else
	eval "$(starship init bash)"
fi

# Load all the environments that are cross-shell
for script_to_source in ~/.config/xsh/*; do
  source "$script_to_source"
done
