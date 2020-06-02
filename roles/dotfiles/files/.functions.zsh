
f () {
    if [ $# -lt 1 ]; then
        echo "Usage: $0 <search_string> [num lines before] [num lines after]"
        echo "Example: $0 neckbeard"
        echo "Example: $0 neckbeard 3 3"
    else

        AFTER=""
        BEFORE=""
        if [ ! -z $2 ]; then
            AFTER="-A $2"
        fi
        if [ ! -z $3 ]; then
            BEFORE="-B $3"
        fi

        grep -Rn $AFTER $BEFORE $1 .
    fi
}

touchpad() {
    # https://wiki.archlinux.org/index.php/Touchpad_Synaptics
    declare -i ID
    ID=`xinput list | grep -Eio '(touchpad|glidepoint)\s*id\=[0-9]{1,2}' | grep -Eo '[0-9]{1,2}'`
    declare -i STATE
    STATE=`xinput list-props $ID|grep 'Device Enabled'|awk '{print $4}'`
    if [ $STATE -eq 1 ]
    then
        xinput disable $ID
        echo "Touchpad disabled."
        # notify-send 'Touchpad' 'Disabled' -i /usr/share/icons/Adwaita/48x48/devices/input-touchpad.png
    else
        xinput enable $ID
        echo "Touchpad enabled."
        # notify-send 'Touchpad' 'Enabled' -i /usr/share/icons/Adwaita/48x48/devices/input-touchpad.png
    fi
}
