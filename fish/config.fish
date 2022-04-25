eval (/opt/homebrew/bin/brew shellenv)

# if status is-login
#	Commands to run in login sessions can go here
# end

if status is-interactive
	starship init fish |source
	zoxide init fish   |source
end

source (brew --prefix asdf)/libexec/asdf.fish
fish_add_path $CARGO_HOME/bin
fish_add_path $GOPATH/bin
fish_add_path $HOME/.local/bin

# Auth sudo with Touch ID
# Gets deleted with every system update or so
if not grep pam_tid /etc/pam.d/sudo > /dev/null 2>&1
	echo 'Adding Touch ID to sudo again...'
	echo "sudo sed -i '.bak' '/sufficient/p; s/smartcard/tid/' /etc/pam.d/sudo"
	sudo sed -i '.bak' '/sufficient/p; s/smartcard/tid/' /etc/pam.d/sudo
end

# FZF Config
set -gx FZF_DEFAULT_COMMAND "fd --type f --follow --hidden --exclude .git --color always"
set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND . \$dir"
set -gx FZF_DEFAULT_OPTS "--ansi --tabstop=4 --preview='bat --color=always {}'"
