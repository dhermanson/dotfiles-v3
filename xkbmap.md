# example of grepping for rules

```bash
grep alt /usr/share/X11/xkb/rules/evdev.lst | grep win
```

# Set caps lock to control

```bash
setxkbmap -layout us -option ctrl:nocaps
```

# Set printscreen as right windows key
```bash
setxkbmap -layout us -option altwin:prtsc_rwin
```
