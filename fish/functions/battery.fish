function battery
    set battery_level (acpi -b | grep -oP '[0-9]+(?=%)' | head -1)
    if test -z "$battery_level"
        echo "Could not read battery level."
        return 1
    end
    
    if test $battery_level -le 5
        notify-send "🪫 Critical Battery" "Battery at $battery_level%! System may shut down soon!" -u critical
    else if test $battery_level -le 10
        notify-send "🔋 Low Battery" "Battery at $battery_level%. Plug in your charger!" -u critical
    end
end
