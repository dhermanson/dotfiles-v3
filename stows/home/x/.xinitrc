session=${1:-openbox}
screenlayout=${2:-laptop_only}

my_x_session_setup () {


    ./.screenlayout/$screenlayout

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

}

[ -f /etc/xprofile ] && . /etc/xprofile
[ -f ~/.xprofile ] && . ~/.xprofile


while xsetroot -name "`date` `uptime | sed 's/.*,//'`"
do
    sleep 1
done &


case $session in
    gnome)
        export GDK_BACKEND=x11
        exec dbus-launch gnome-session
        ;;
    kde)
        exec startkde
        ;;
    xfce)
        exec dbus-launch startxfce4
        ;;
    i3)
        my_x_session_setup
        exec dbus-launch i3
        ;;
    xmonad) 
        my_x_session_setup
        exec dbus-launch xmonad-session
        ;;
    bspwm) 
        my_x_session_setup
        sxhkd &
        exec dbus-launch bspwm
        ;;
    openbox) 
        my_x_session_setup
        # export KDE_SESSION_VERSION=5
        # export XDG_CURRENT_DESKTOP=KDE
        # pnmixer &
        # tint2 &
        # xfce4-panel &
        exec dbus-launch openbox-session
        ;;
    *) 
        my_x_session_setup
        exec dbus-launch $1
        ;;
esac
