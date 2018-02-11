# My dotfiles

Run `./install.sh` to link scripts

## Other settings
### 16 Colors for Terminal Emulator
Colors can be different, it's just a note.

|Type  |Black  |Red    |Green  |Yellow |Blue   |Magenta|Cyan   |White  |
|-     |-      |-      |-      |-      |-      |-      |-      |-      |
|Normal|#333333|#D12D24|#4D9407|#CCB30A|#174299|#AD5799|#33BBC8|#BBBBBB|
|Bright|#707070|#EB433B|#89E62E|#ECD123|#7272CF|#C76BB1|#14F0F0|#FFFFFF|

Font Color: #D9D9D9

Background Color: #121212

### Disk Partition
```
blkid; ls -l /dev/disk/by-uuid
sudo cp /etc/fstab /etc/fstab.bak
sudo vi /etc/fstab
```
`UUID=XXX /media/Data ntfs-3g uid=1000,gid=1000,umask=0002 0 0`

[fstab guide](http://www.linuxstall.com/fstab/),
[ntfs-3g](https://wiki.archlinux.org/index.php/NTFS-3G#Configuring),
[/mnt vs /media](https://askubuntu.com/questions/22215/why-have-both-mnt-and-media)

### Synaptics touchpad
`sudo vi /usr/share/X11/xorg.conf.d/50-synaptics.conf`
```
Section "InputClass"
        ...
        Option "TapButton2" "2"
EndSection
```
"TapButton2" "2" means: "two-finger tap" "mouse middle click"

### NTU VPN
[Installation](http://ccnet.ntu.edu.tw/vpn/for-ubuntu.html)

Append `--fg` to `$HOME/.local/share/applications/ms-jnc.desktop` if installed,
otherwise some functions won't work.
