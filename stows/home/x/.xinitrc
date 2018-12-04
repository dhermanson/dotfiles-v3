session=${1:-xmonad}
screenlayout=${2:-laptop_only}

my_x_session_setup () {
    # load resources
    xrdb -load ~/.Xresources

    # Set up an icon tray
    # stalonetray &
    # trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 15 --height 28 --transparent true --tint 0x000000 &

    ./.screenlayout/$screenlayout

    # trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 15 --height 28 --alpha 0 --transparent true --tint 0x000000 &

    # feh --bg-fill ~/.wallpaper/gnu.png &
    feh --bg-fill /usr/share/backgrounds/warty-final-ubuntu.png &

    xautolock -time 60 -locker slock &


    if [ -x /usr/bin/dropbox ]; then
        /usr/bin/dropbox start &
    fi

    # notification daemon
    dunst &

    # unclutter &

    # start network manager applet
    nm-applet &

    # start urxvt daemon
    urxvtd &

    # start udiskie to handle media
    udiskie &

    # start power manager
    # xfce4-power-manager & # this doesn't add an icon to the tray

    if [ -x /usr/bin/xsettingsd ]; then
        touch ~/.xsettingsd
        #/usr/bin/xsettingsd &
    fi

    dbus-update-activation-environment --systemd DBUS_SESSION_BUS_ADDRESS DISPLAY XAUTHORITY

    # From https://wiki.archlinux.org/index.php/GNOME/Keyring#xinitrc_method
    if [ -x /usr/bin/gnome-keyring-daemon ]; then
        eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
        export SSH_AUTH_SOCK
    fi


    # make KDE apps work properly in non-kde environment
    export KDE_SESSION_UID=1000
    export KDE_SESSION_VERSION=5
    export XDG_CURRENT_DESKTOP=KDE
}

# Key repeat
# xset r rate 250 40
xset r rate 250 60

exec emacs --daemon &

# music player daemon
mpd &

exec redshift &

# keyboard setup
xmodmap ~/.Xmodmap &

case $session in
    gnome)
        # exec dbus-launch gnome-session
        exec gnome-session
        ;;
    kde)
        # exec dbus-launch startkde
        exec startkde
        ;;
    i3)
        my_x_session_setup
        # exec dbus-launch i3 -V >> ~/i3log-$(date +'%F-%k-%M-%S') 2>&1
        # exec dbus-launch i3
        exec i3
        ;;
    xmonad) 
        my_x_session_setup
        #exec dbus-launch xmonad
        exec xmonad
        ;;
    *) 
        my_x_session_setup
        # exec dbus-launch $1
        exec $1
        ;;
esac
