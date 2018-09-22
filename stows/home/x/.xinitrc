xmodmap ~/.Xmodmap

xrdb -load ~/.Xresources

# Key repeat
# Set:
#   $ xset r rate [delay (ms)] [rate (hz)]
# Get current value:
#   $ xset q
# xset r rate 280 50

# feh --recursive --randomize --bg-fill ~/.wallpaper &
feh --bg-fill ~/.wallpaper/background.jpg &

xautolock -time 1 -locker slock &

# eval "$(ssh-agent)"
# eval "$(gpg-agent --daemon)"

# pulseaudio
# start-pulseaudio-x11

exec emacs --daemon &
# exec nm-applet &
# start dropbox if it's installed (we do it here rather than via systemd
# because the icon won't show up otherwise)
if [ -x /usr/bin/dropbox ]; then
    /usr/bin/dropbox start &
fi

if [ -x /usr/bin/pasystray ]; then
    pasystray &
fi

if [ -x /usr/bin/nm-applet ]; then
    nm-applet &
fi

if [ -x /usr/bin/blueman-applet ]; then
    gsettings set org.blueman.plugins.powermanager auto-power-on false
    blueman-applet &
fi

if [ -x /usr/bin/dunst ]; then
    dunst &
fi

if [ -x /usr/bin/xsettingsd ]; then
    touch ~/.xsettingsd
    /usr/bin/xsettingsd &
fi

# From https://wiki.archlinux.org/index.php/GNOME/Keyring#xinitrc_method
if [ -x /usr/bin/gnome-keyring-daemon ]; then
    dbus-update-activation-environment --systemd DISPLAY
    eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
    export SSH_AUTH_SOCK
fi

#exec gnome-session
# exec dbus-launch i3 -V >> ~/i3log-$(date +'%F-%k-%M-%S') 2>&1
exec dbus-launch i3
