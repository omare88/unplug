 #!/bin/bash

    while true
    do
        export DISPLAY=:0.0
        battery_level=`acpi -b | grep -P -o '[0-9]+(?=%)'`
        if on_ac_power; then
            if [ $battery_level -ge 80 ]; then
                notify-send "Battery charging above 80%. Please unplug your AC adapter!" "Charging: ${battery_level}% " --icon=battery-full | play *.wav
                sleep 45 # stays on for 45 seconds
                if on_ac_power; then
                    gnome-screensaver-command -l   # locks the screen if you don't unplug AC adapter after 20 seconds
                fi
             fi
        else
             if [ $battery_level -le 40 ]; then
                notify-send "Battery is lower 40%. Need to charging! Please plug your AC adapter." "Charging: ${battery_level}%" --icon=battery-low | play *.wav
                sleep 45 # stays on for 45 seconds
                if ! on_ac_power; then
                    gnome-screensaver-command -l   # locks the screen if you don't plug AC adapter after 20 seconds
                fi
             fi
        fi
        sleep 120 # 120 seconds
    done
