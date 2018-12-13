# My dotfiles
## Installation
1. Install all requirement first

   `sudo apt-get install -y zsh tmux xsel`

   `sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" && rm ~/.zshrc; git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm; git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim`

2. Download and link the scripts

   `git clone https://github.com/doraeric/dotfiles.git ~/dotfiles; cd ~/dotfiles; ./install.sh`

3. `vi ~/.vim/vimrc` to check what plugin to install

4. Install plugins

   `~/.tmux/plugins/tpm/scripts/install_plugins.sh; vim +PluginInstall +qall; [ -n "$ZSH_CUSTOM" ] || ZSH_CUSTOM=~/.oh-my-zsh/custom; git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions`

5. (optional) Compile vim plugin YouCompleteMe

   `sudo apt-get install build-essential cmake; cd ~/.vim/bundle/YouCompleteMe; ./install.py --clang-completer`

6. (optional) Load local setting

   `git clone https://github.com/doraeric/dotfiles.local.git ~/dotfiles/home.local; cd ~/dotfiles; ./install.sh`

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

exFAT

`sudo apt-get install exfat-fuse exfat-utils`

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
