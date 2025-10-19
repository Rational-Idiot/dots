function toggle-nm
    if pgrep -x nm-applet > /dev/null
        echo "Killing nm-applet..."
        pkill -x nm-applet
    else
        echo "Starting nm-applet..."
        nohup nm-applet >/dev/null 2>&1 &
    end
end
