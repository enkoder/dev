#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

if xrandr | grep "HDMI-1 connected"; then
    MONITOR="HDMI-1" polybar -c ~/.config/polybar/config enkoder &
fi

if xrandr | grep "HDMI-2 connected"; then
    MONITOR="HDMI-2" polybar -c ~/.config/polybar/config enkoder &
fi

if xrandr | grep "eDP-1 connected"; then
    MONITOR="eDP-1" polybar -c ~/.config/polybar/config enkoder &
fi

if xrandr | grep "DP-1 connected"; then
    MONITOR="DP-1" polybar -c ~/.config/polybar/config enkoder &
fi

if xrandr | grep "DP-2-1 connected"; then
    MONITOR="DP-2-1" polybar -c ~/.config/polybar/config enkoder &
fi

if xrandr | grep "DP-2-2 connected"; then
    MONITOR="DP-2-2" polybar -c ~/.config/polybar/config enkoder &
fi

if xrandr | grep "Virtual1 connected"; then
    MONITOR="Virtual1" polybar -c ~/.config/polybar/config enkoder &
fi

if xrandr | grep "VGA-1 connected"; then
    MONITOR="VGA-1" polybar -c ~/.config/polybar/config enkoder &
fi
