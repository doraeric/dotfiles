#!/bin/sh
# https://gist.github.com/ManuelTS/5ed3fa4e5035e489796b374e0654b649
# Uninstalls the Unity Editor on Ubuntu.
#
# Tested for Unity 2017.30f1 downloaded from https://beta.unity3d.com/download/3c89f8d277f5/public_download.html
# and Ubuntu 17.10, but it should work with other version too.
#
# Unity is expected to be installed in your home folder, otherwise
# change the first remove command to your installation path.
#
# Execute this program as root, e.g. "sudo sh UninstallUnity.sh"

rm -rf /home/$USER/Unity*
rm -rf /home/$USER/.cache/unity3d
rm -rf /home/$USER/.config/unity3d
rm -rf /home/$USER/.config/Unity
rm -rf /home/$USER/.local/share/unity3d
