fish_vi_key_bindings
if status is-interactive
    zoxide init --cmd cd fish | source

    # Direnv + Zoxide
    command -v direnv &> /dev/null && direnv hook fish | source
    command -v zoxide &> /dev/null && zoxide init fish --cmd cd | source

    # Better ls
    command -v eza &> /dev/null && alias ls='eza --icons --group-directories-first -1'

    # Abbrs
    abbr l 'ls'
    abbr ll 'ls -l'
    abbr la 'ls -a'
    abbr lla 'ls -la'
    abbr lt 'ls --tree'
    abbr timeshift 'sudo -E timeshift-gtk'
    abbr zi '__zoxide_zi'
    abbr nmtui 'impala'
    abbr logout 'loginctl terminate-user $USER'

    # Custom colours
    cat ~/.local/state/caelestia/sequences.txt 2> /dev/null
    # For jumping between prompts in foot terminal
    function mark_prompt_start --on-event fish_prompt
        echo -en "\e]133;A\e\\"
    end

    # Custom fish config
    set -q XDG_CONFIG_HOME && set -l cConf $XDG_CONFIG_HOME/caelestia || set -l cConf $HOME/.config/caelestia
    source $cConf/user-config.fish 2> /dev/null
end

function fzf_history_search
     set -l selected (history | fzf \
        --height 40% \
        --reverse \
        --border \
        --preview 'printf "%s\n" {} | bat --color=always --style=plain --language=sh')

  if test -n "$selected"
        commandline --replace ""
        commandline --replace -- (string trim "$selected")
        commandline -f repaint
        commandline -f execute
    end
end

bind -M insert \cf fzf_history_search

# Proxy settings - START
set -gx http_proxy "http://IIT2024128:Ether%409095@172.31.2.3:8080"
set -gx https_proxy "http://IIT2024128:Ether%409095@172.31.2.3:8080"
set -gx HTTP_PROXY "http://IIT2024128:Ether%409095@172.31.2.3:8080"
set -gx HTTPS_PROXY "http://IIT2024128:Ether%409095@172.31.2.3:8080"
set -gx ftp_proxy "http://IIT2024128:Ether%409095@172.31.2.3:8080"
set -gx FTP_PROXY "http://IIT2024128:Ether%409095@172.31.2.3:8080"
set -gx no_proxy "localhost,127.0.0.1,::1"
set -gx NO_PROXY "localhost,127.0.0.1,::1"
# Proxy settings - END


