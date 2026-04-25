function hotspot
    set iface_wifi wlan0
    set iface_lan enp7s0
    set ssid Slave
    set pass M196883S

    if test "$argv[1]" = "status"
        set active (nmcli -t -f NAME connection show --active | grep '^Hotspot$')
        if test -z "$active"
            echo "Hotspot: OFF"
        else
            echo "Hotspot: ON"
            echo
            nmcli dev wifi show-password
        end
        return
    end

    if test "$argv[1]" = "off"
      echo "Stopping hotspot..."
      nmcli -t -f NAME connection show --active | grep -q Hotspot; and nmcli connection down Hotspot
      return
    end  

    echo "Starting hotspot..."

    # Ensure wifi is enabled
    nmcli radio wifi on

    # Enable forwarding
    sudo sysctl -w net.ipv4.ip_forward=1 >/dev/null

    # Ensure NAT exists
    sudo iptables -t nat -C POSTROUTING -s 10.42.0.0/24 -o $iface_lan -j MASQUERADE 2>/dev/null
    or sudo iptables -t nat -A POSTROUTING -s 10.42.0.0/24 -o $iface_lan -j MASQUERADE

    sudo iptables -C FORWARD -i $iface_wifi -o $iface_lan -j ACCEPT 2>/dev/null
    or sudo iptables -A FORWARD -i $iface_wifi -o $iface_lan -j ACCEPT

    sudo iptables -C FORWARD -i $iface_lan -o $iface_wifi -m state --state RELATED,ESTABLISHED -j ACCEPT 2>/dev/null
    or sudo iptables -A FORWARD -i $iface_lan -o $iface_wifi -m state --state RELATED,ESTABLISHED -j ACCEPT

    nmcli device wifi hotspot ifname $iface_wifi ssid $ssid password $pass
    nmcli dev wifi show-password
end
