#!/bin/sh

# Ensures an ssh agent is running
eval `ssh-agent`

# sets caps lock as ctrl
setxkbmap -option ctrl:nocaps
xrdb -merge ~/.Xresources

# flux like app
redshift 37.7749:122.4194 &

# starts xfce4 notification daemon
/usr/lib/xfce4/notifyd/xfce4-notifyd &

# start up the best window manager ever
exec i3 --shmlog-size=26214400
