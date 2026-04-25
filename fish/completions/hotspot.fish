# Subcommand completions for the hotspot function

complete -c hotspot -f

# Subcommands

complete -c hotspot -n "__fish_use_subcommand" -a on -d "Start the hotspot"
complete -c hotspot -n "__fish_use_subcommand" -a off -d "Stop the hotspot"
complete -c hotspot -n "__fish_use_subcommand" -a status -d "Show hotspot status and QR code"
