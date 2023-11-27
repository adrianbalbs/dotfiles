[[ -f ~/.zshrc ]] && . ~/.zshrc

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi

if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    export MOZ_ENABLE_WAYLAND=1
fi

# Created by `pipx` on 2023-08-10 09:20:57
export PATH="$PATH:/home/adrian/.local/bin"
export PATH="$PATH:/home/adrian/go/bin"
export PATH=/home/adrian/scripts:$PATH
