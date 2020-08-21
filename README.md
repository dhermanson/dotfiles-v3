# Dotfiles
My dotfiles. More to come.

## Thinkpad suspend touchpad workaround for thinkpad
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1788928


## Gnome gsettings keybindings
See [this stackoverflow article](https://askubuntu.com/questions/1069580/ubuntu-18-04-supero-cant-trigger-shortcut-event)  on how to unset lots of Gnome's keybindings.

For instance, to figure out what what's grabbing the `<Super>o` key combo:
```bash
(for schema in $(gsettings list-schemas); do gsettings list-recursively $schema; done) | grep '<Super>o'
```

It showed org.gnome.settings-daemon.plugins.media-keys rotate-video-lock-static ['<Super>o'] so I removed it with
```bash
gsettings set org.gnome.settings-daemon.plugins.media-keys rotate-video-lock-static "[]"
```

I restarted and was able to use the key again. I found lots more unwanted bindings with:

```
(for schema in $(gsettings list-schemas); do gsettings list-recursively $schema; done) | grep '<Super>'
```
