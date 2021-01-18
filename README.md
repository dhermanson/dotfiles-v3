# Dotfiles
My dotfiles.

Clone with submodules:

```sh
git clone --recurse-submodules <github url> 
```

After cloning, if you've forgotten to clone submodules:

```sh
git submodule update --init --recursive
```

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

## submodules
https://stackoverflow.com/questions/10168449/git-update-submodules-recursively
`git submodule --init --recursive`

### Tmux Plugin Manager(TPM)
See [TPM's section on installing plugins](https://github.com/tmux-plugins/tpm#installing-plugins). You must hit `prefix + I` in order to install plugins. There is another [section on key bindings](https://github.com/tmux-plugins/tpm#key-bindings).

# Truecolor
read [this article](https://github.com/syl20bnr/spacemacs/wiki/Terminal)


## Manual Installs

### Ruby
Install a version of ruby using rbenv:
```sh
rbenv install -l
rbenv install 2.7.1
```

### Java
Download an adoptopjdk version of java and install it:
```sh
╭─derick@thinkpad /opt/jvm/jdk-11.0.9.1+1/bin
╰─$ sudo update-alternatives --install /usr/local/bin/java java /opt/jvm/jdk-11.0.9.1+1/bin/java 0
update-alternatives: using /opt/jvm/jdk-11.0.9.1+1/bin/java to provide /usr/local/bin/java (java) in auto mode

╭─derick@thinkpad /opt/jvm/jdk-11.0.9.1+1/bin
╰─$ sudo update-alternatives --install /usr/local/bin/javac javac /opt/jvm/jdk-11.0.9.1+1/bin/javac 0
update-alternatives: using /opt/jvm/jdk-11.0.9.1+1/bin/javac to provide /usr/local/bin/javac (javac) in auto mode

update-alternatives --list java
update-alternatives --list javac
sudo update-alternatives --config java
sudo update-alternatives --config javac

```

