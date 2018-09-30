session=${1:-xmonad}

my_x_session_setup () {
    # load resources
    xrdb -load ~/.Xresources

    # Key repeat
    xset r rate 250 40

    feh --bg-fill ~/.wallpaper/gnu.png &

    xautolock -time 5 -locker slock &

    exec emacs --daemon &

    if [ -x /usr/bin/dropbox ]; then
        /usr/bin/dropbox start &
    fi

    # notification daemon
    dunst &

    # cursor hiding daemon
    unclutter &

    if [ -x /usr/bin/xsettingsd ]; then
        touch ~/.xsettingsd
        /usr/bin/xsettingsd &
    fi

    exec redshift &

    dbus-update-activation-environment --systemd DBUS_SESSION_BUS_ADDRESS DISPLAY XAUTHORITY

    # From https://wiki.archlinux.org/index.php/GNOME/Keyring#xinitrc_method
    if [ -x /usr/bin/gnome-keyring-daemon ]; then
        eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
        export SSH_AUTH_SOCK
    fi

    #exec gnome-session
    # exec dbus-launch i3 -V >> ~/i3log-$(date +'%F-%k-%M-%S') 2>&1
    # exec dbus-launch i3

    # keyboard setup
    xmodmap ~/.Xmodmap
}


echo $session
case $session in
    gnome)
        exec gnome-session
        ;;
    kde)
        exec startkde
        ;;
    i3)
        my_x_session_setup
        exec dbus-launch i3
        ;;
    xmonad) 
        my_x_session_setup
        exec dbus-launch xmonad
        ;;
    *) 
        my_x_session_setup
        exec dbus-launch $1
        ;;
esac
