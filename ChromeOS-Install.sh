#!/bin/sh
echo "Installing Dependencies"
sudo apt update && sudo apt -y install wget pv tar grub-customizer unzip cgpt lzip 
read -p "In which folder do you want to install ChromeOS" location
read -p "What size will you give ChromeOS" size
read -p "You are sure? [y/n]" yn
case $yn in
    [Yy]* ) echo "Ok, Proceeding installation on $partition";
            chmod +x chromeos-install.sh;
            sudo bash chromeos-install.sh -src rammus_recovery.bin -dst $location -s $size;
            read -p "Do you want to add boot options to ChromeOS? [y/n]" boot;
            case $yn in;
                [Yy]* ) echo "Copy the above grub menu entry in grub customizer";
                        sudo grub-customizer;
                        break;;
                [Nn]* ) exit;;
                * ) echo "Please answer yes or no.";;
            break;;
    [Nn]* ) exit;;
    * ) echo "Please answer yes or no.";;
