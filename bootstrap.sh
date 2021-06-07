#!/bin/bash

# vars
reboot_required=false

# functions
function do_reboot {
  if $reboot_required
  then
    osascript -e 'tell application "Finder" to restart'
  fi
}
function swupdate {
  if softwareupdate -l | grep -q "Update found"
  then
    echo "New software available. Installing updates."
    sudo softwareupdate -ia && reboot_required=true
  fi
}
function install_homebrew {
  if [ ! $(which brew) ]
  then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  fi
}

# Update software
swupdate

# Install homebrew
install_homebrew

# Install ansible
brew install ansible
do_reboot
