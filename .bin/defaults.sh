#!/bin/zsh

if [ "$(uname)" != "Darwin" ] ; then
	echo "Not macOS!"
	exit 1
fi


# ====================
#
# Finder
#
# ====================

# Show hidden files by defaults
defaults write com.apple.finder AppleShowAllFiles -bool true

# Show files with all extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Avoid creating `.DS_Store` files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# ====================
#
# SystemUIServer
#
# ====================

# Display date, day, and time in the menu bar
defaults write com.apple.menuextra.clock DateFormat -string ''M'月'd'日('E')' H'時'mm'分'ss'秒'''

# Display battery level in the menu bar
defaults write com.apple.menuextra.battery ShowPercent -string "YES"

# Show Bluetooth in the menu bar
defaults write com.apple.controlcenter "NSStatusItem Visible Bluetooth" -bool true

# ====================
#
# Other
#
# ====================

# Save screenshots as PNGs （スクリーンショット保存形式をPNGにする）
defaults write com.apple.screencapture type -string "png"
