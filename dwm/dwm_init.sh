#! /usr/bin/env sh

nitrogen --restore &
emacs --daemon &

setxkbmap -layout us -option ctrl:nocaps
setxkbmap -layout us -option altwin:prtsc_rwin


exec dwm
