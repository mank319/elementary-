#!/bin/bash

(( EUID != 0 )) && exec sudo -- "$0" "$@"

read -p "Do you want to replace the default OwnCloud status icons with the new ones [Y/n]?is
This will install a patched version sni-qt thus replacing the default one!" yn

if [[ $yn =~ ^[Yy]$ ]] || [[ $yn == "" ]]; then
    
    echo "Adding the repository"
    add-apt-repository --yes ppa:rpeshkov/ppa
    
    echo "Updating package list"
    apt-get -y update
    
    echo "Upgrading system"
    apt-get -y upgrade
    
    echo "Creating directory..."
    mkdir -p /usr/share/sni-qt/icons
    
    echo "Copying files to the directory..."
    cp ./owncloud/* /usr/share/sni-qt/icons/
    
    echo "Removing the repository"
    add-apt-repository --remove --yes ppa:rpeshkov/ppa
    
    echo
    echo "The Owncloud icon set has been replaced successfuly! Start OwnCloud and select the \"Monochrome Icons\" option in the settings menu to check it out."
fi
