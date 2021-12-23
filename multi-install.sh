#!/bin/sh
if [ "$(id -u)" -eq 0 ]; then
        # user is admin
        echo "Installing Dependencies"
        apt update && apt -y install wget pv tar grub-customizer unzip cgpt lzip 
        read -p "In which folder do you want to install ChromeOS eg. "/home/user/ChromeOS.img" for ChromeOS.img in "/home/user/" ? " location
        read -p "What size will you give ChromeOS eg. "20" for 20 GB ? " size
        read -p "You are sure? [y/n] " yn
        case $yn in
            [Yy]* ) echo "Ok, Proceeding installation on $location";
                    chmod +x chromeos-install.sh;
                    bash chromeos-install.sh -src chromeos_recovery.bin -dst $location -s $size;
                    break;;
            [Nn]* ) exit;;
            * ) echo "Please answer yes or no.";;
        esac
        read -p "Do you want to add boot options to ChromeOS? [y/n] " boot
        case $boot in
            [Yy]* ) echo "Copy the above grub menu entry in grub customizer";
                    grub-customizer;
                    break;;
            [Nn]* ) exit;;
            * ) echo "Please answer yes or no.";;
        esac
        echo "Done"
else
        # user is not admin
        echo "Command must be run as root user"
        exit
fi
