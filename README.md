# ~/.config

## Prerequesity
```shell
sudo pacman -S alacritty  # terminal
sudo pacman -S alsa-utils  # volume control
sudo pacman -S ranger  # file browser
sudo pacman -S rofi  # launcher
```

## Desktop Environment
```shell
sudo pacman -S xorg-server xorg-xinit lightdm lightdm-gtk-greeter
sudo systemctl enable lightdm.service
cp /etc/X11/xinit/xinitrc ~/.xinitrc
sudo pacman -S --needed base-devel git
git clone https://aur.archlinux.org/awesome-git.git
cd awesome-git
makepkg -fsri
```

## Troubleshooting

### Resolution
Install `xorg-xrandr` to check and set resolution.
```shell
xrandr  # show outputs information
xrandr --output HDMI-1 --auto  # set preferred resolution
```
### Scale factor
```shell
cp /etc/X11/xinit/xinitrc ~/.xprofile
touch ~/.Xresources
```
And add following lines to `~/.Xresources`
```
Xft.dpi: 192

! These might also be useful depending on your monitor and personal preference:
Xft.autohint: 0
Xft.lcdfilter:  lcddefault
Xft.hintstyle:  hintfull
Xft.hinting: 1
Xft.antialias: 1
Xft.rgba: rgb
```
