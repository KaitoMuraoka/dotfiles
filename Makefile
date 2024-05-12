# Do everything.
all: init link defaults brew

# Set initial preference.
init:
	chmod +x .bin/init.sh
	.bin/init.sh

# Link dotfiles.
link:
	chmod +x .bin/link.sh
	.bin/link.sh

# Set macOS system preferences.
defaults:
	chmod +x .bin/defaults.sh
	.bin/defaults.sh

# Install macOS applications.
brew:
	chmod +x .bin/brew.sh
	.bin/brew.sh

update:
	# chmod +x .bin/brew-cleanup.sh
	.bin/brew-cleanup.sh
