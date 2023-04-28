


if [[ -z "$(which nix)" ]]; then
	if [ -e /home/stroxler/.nix-profile/etc/profile.d/nix.sh ]; then
		source /home/stroxler/.nix-profile/etc/profile.d/nix.sh;
	fi
fi
