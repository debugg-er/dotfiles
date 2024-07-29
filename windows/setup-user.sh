#!/bin/bash

set -e

printf "Username: "
read username
printf "Password: "
read password

echo "$password" | passwd --stdin

echo "%wheel ALL=(ALL) ALL" > /etc/sudoers.d/wheel
useradd -m -G wheel -s /bin/bash $username
echo "$password" | passwd $username --stdin

sed -i -e 's/#Server = https:\/\/geo.mirror/Server = https:\/\/geo.mirror/' /etc/pacman.d/mirrorlist