#!/bin/bash
pid=$$
name=$(cat -A /proc/$pid/cmdline | tr '^@' ' ' | awk '{print $2}')
[ "`id -u`" -ne 0 ] && echo -e "\033[31mYou are not running this as a user with elevated privileges.\033[0m Please either \033[32mlog in as root and re-run this script\033[0m, or run \033[32msudo $name\033[0m. This script will now terminate." && exit
echo "Checking operating system version..."
osstr=`hostnamectl |grep "Operating System" |awk '{$1=""; $2=""; print $0}'`
echo "Detected operating system as:"
echo -e "\033[32m$osstr\033[0m"
osname=`echo "$osstr" |awk '{print $1}'`
osver=`echo "$osstr" |sed 's/GNU\/Linux//g'`
case `echo $osver` in
        "Debian 13"*)
                echo "Installing GPG signing key, please wait..."
                curl https://online-amateur-radio-club-m0ouk.github.io/oarc-packages/hibby.key | tee /etc/apt/trusted.gpg.d/hibby.asc
                echo -e "\033[32mGPG signing key installed correctly.\033[0m"
                echo "Adding Debian testing repository for OARC packages..."
                echo "#OARC Packet Radio Packages" >> /etc/apt/sources.list
                echo "deb https://online-amateur-radio-club-m0ouk.github.io/oarc-packages testing main" >> /etc/apt/sources.list
                echo -e "\033[32mRepository added correctly.\033[0m"
        ;;
        "Debian 12"*)
                echo "Installing GPG signing key, please wait..."
                curl https://online-amateur-radio-club-m0ouk.github.io/oarc-packages/hibby.key | tee /etc/apt/trusted.gpg.d/hibby.asc
                echo -e "\033[32mGPG signing key installed correctly.\033[0m"
                echo "Adding Debian stable repository for OARC packages..."
                echo "#OARC Packet Radio Packages" >> /etc/apt/sources.list
                echo "deb https://online-amateur-radio-club-m0ouk.github.io/oarc-packages bookworm main" >> /etc/apt/sources.list
                echo -e "\033[32mRepository added correctly.\033[0m"
        ;;
        "Ubuntu 22.04"*)
                echo "Installing GPG signing key, please wait..."
                curl https://online-amateur-radio-club-m0ouk.github.io/oarc-packages/hibby.key | tee /etc/apt/trusted.gpg.d/hibby.asc
                echo -e "\033[32mGPG signing key installed correctly.\033[0m"
                echo "Adding Ubuntu jammy repository for OARC packages..."
                echo "#OARC Packet Radio Packages" >> /etc/apt/sources.list
                echo "deb https://online-amateur-radio-club-m0ouk.github.io/oarc-packages jammy main" >> /etc/apt/sources.list
                echo -e "\033[32mRepository added correctly.\033[0m"
        ;;
        "Ubuntu 24.04"*)
                echo "Installing GPG signing key, please wait..."
                curl https://online-amateur-radio-club-m0ouk.github.io/oarc-packages/hibby.key | tee /etc/apt/trusted.gpg.d/hibby.asc
                echo -e "\033[32mGPG signing key installed correctly.\033[0m"
                echo "Adding Ubuntu jammy repository for OARC packages..."
                echo "#OARC Packet Radio Packages" >> /etc/apt/sources.list
                echo "deb https://online-amateur-radio-club-m0ouk.github.io/oarc-packages noble main" >> /etc/apt/sources.list
                echo -e "\033[32mRepository added correctly.\033[0m"
        ;;
        "Raspbian 12"*)
                echo "Installing GPG signing key, please wait..."
                curl https://online-amateur-radio-club-m0ouk.github.io/oarc-packages/hibby.key | tee /etc/apt/trusted.gpg.d/hibby.asc
                echo -e "\033[32mGPG signing key installed correctly.\033[0m"
                echo "Adding Raspberry Pi OS stable repository for OARC packages..."
                echo "#OARC Packet Radio Packages" >> /etc/apt/sources.list
                echo "deb https://online-amateur-radio-club-m0ouk.github.io/oarc-packages bookworm main" >> /etc/apt/sources.list
                echo -e "\033[32mRepository added correctly.\033[0m"
        ;;
        "Raspbian 11"*)
                echo "Installing GPG signing key, please wait..."
                curl https://online-amateur-radio-club-m0ouk.github.io/oarc-packages/hibby.key | tee /etc/apt/trusted.gpg.d/hibby.asc
                echo -e "\033[32mGPG signing key installed correctly.\033[0m"
                echo "Adding Raspberry Pi OS oldstable repository for OARC packages..."
                echo "#OARC Packet Radio Packages" >> /etc/apt/sources.list
                echo "deb https://online-amateur-radio-club-m0ouk.github.io/oarc-packages bullseye main" >> /etc/apt/sources.list
                echo -e "\033[32mRepository added correctly.\033[0m"
        ;;
        "Debian 11"*)
                echo "Installing GPG signing key, please wait..."
                curl https://online-amateur-radio-club-m0ouk.github.io/oarc-packages/hibby.key | tee /etc/apt/trusted.gpg.d/hibby.asc
                echo -e "\033[32mGPG signing key installed correctly.\033[0m"
                echo "Adding Raspberry Pi OS oldstable repository for OARC packages..."
                echo "#OARC Packet Radio Packages" >> /etc/apt/sources.list
                echo "deb https://online-amateur-radio-club-m0ouk.github.io/oarc-packages bullseye main" >> /etc/apt/sources.list
                echo -e "\033[32mRepository added correctly.\033[0m"
        ;;
        *)
                echo "No repository to add - check you are running a compatible operating system. Please see https://online-amateur-radio-club-m0ouk.github.io/oarc-packages/ for more information" && exit
        ;;
esac
echo "Updating your package lists..."
apt update
echo -e "\033[32mPackage list update complete\033[0m"
echo -e "This script will now exit. You can install packages from the new repository by running:"
echo ""
echo -e "\033[32msudo apt install <packagename>\033[0m"
echo ""
echo "Or if you are logged in as root already:"
echo ""
echo -e "\033[32mapt install <packagename>\033[0m"
echo ""
exit
