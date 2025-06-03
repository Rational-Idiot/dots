# Add user configurations here
# For HyDE to not touch your beloved configurations,
# we added 2 files to the project structure:
# 1. ~/.hyde.zshrc - for customizing the shell related hyde configurations
# 2. ~/.zshenv - for updating the zsh environment variables handled by HyDE // this will be modified across updates

#  Plugins 
# oh-my-zsh plugins are loaded  in ~/.hyde.zshrc file, see the file for more information

#  Aliases 
# Add aliases here

#  This is your file 
# Add your configurations here

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
. "$HOME/.cargo/env"

export EDITOR=nvim
export MOZ_ENABLE_WAYLAND=1
export XAUTHORITY=$HOME/.Xauthority

# export http_proxy="http://172.31.2.4:8080";
# export https_proxy="https://172.31.2.4:8080";

alias proxy='source ./proxy.sh'
export KITTY_ENABLE_WAYLAND=1
alias nvim='kitty --class nvim-term --config <(echo "include ~/.config/kitty/kitty.conf\nwindow_padding_width 0") nvim'
export LIBVA_DRIVER_NAME=iHD
export MOZ_ENABLE_WAYLAND=1

export PATH=$PATH:/home/aryan/.spicetify
eval "$(zoxide init --cmd cd zsh)"
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS='
  --layout=default
  --height=100%
  --preview "bat --style=numbers --color=always --line-range :100 {}"
  --preview-window=right:70%:wrap
  --border
'
alias timeshift="sudo -E timeshift-gtk"
# eval "$(keychain --quiet --eval id_rsa)"

# compile: compile a .cpp file and name the binary after the file (no .cpp)
# test() {
#   local src="$1"
#   local base="${src%.*}"
#
#   # Compile with C++23 and common warning flags:
#   g++ -std=c++23 -Wall -Wextra "$src" -o "$base"
#   if [[ $? -eq 0 ]]; then
#     echo "➜  Compiled '$src' → './$base'"
#     echo "➜  Running './$base'"
#     ./"$base"
#   else
#     echo "⚠️  Compilation failed for '$src'"
#   fi
# }

test() {
  local src="$1"
  local base="${src%.*}"

  # Compile with C++23 and common warning flags:
  g++ -std=c++23 -Wall -Wextra "$src" -o "$base"
  if [[ $? -ne 0 ]]; then
    echo "⚠️  Compilation failed for '$src'"
    return 1
  fi

  echo "➜  Compiled '$src' → './$base'"

  # Figure out how to pull clipboard contents. On Wayland (e.g. Hyprland) you likely have wl-paste.
  # On traditional X11, xclip or xsel might be available. We’ll check for wl-paste first, then xclip.
  if command -v wl-paste >/dev/null 2>&1; then
    echo "➜  Running './$base' with clipboard as stdin (via wl-paste)…"
    wl-paste | ./"$base"
  elif command -v xclip >/dev/null 2>&1; then
    echo "➜  Running './$base' with clipboard as stdin (via xclip)…"
    xclip -selection clipboard -o | ./"$base"
  else
    echo "⚠️  Could not find wl-paste or xclip. Running without clipboard:"
    ./"$base"
  fi
}

