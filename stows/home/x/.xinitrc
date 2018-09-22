xmodmap ~/.Xmodmap
xrdb -load ~/.Xresources

feh --recursive --randomize --bg-fill ~/.wallpaper &

exec emacs --daemon &
exec nm-applet &

#exec gnome-session
# exec i3 -V >> ~/i3log-$(date +'%F-%k-%M-%S') 2>&1
exec dbus-launch i3
