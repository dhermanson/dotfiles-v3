session=${1:-i3}

my_x_session_setup () {
    # load resources
    xrdb -load ~/.Xresources


    # feh --bg-fill ~/.wallpaper/gnu.png &

    xautolock -time 5 -locker slock &


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
xset r rate 250 40

exec emacs --daemon &

# music player daemon
mpd &

exec redshift &

# keyboard setup
xmodmap ~/.Xmodmap &

case $session in
    gnome)
        exec dbus-launch gnome-session
        ;;
    kde)
        exec dbus-launch startkde
        ;;
    i3)
        my_x_session_setup
        # exec dbus-launch i3 -V >> ~/i3log-$(date +'%F-%k-%M-%S') 2>&1
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
