[[ -f ~/.zshrc ]] && . ~/.zshrc

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi

# Created by `pipx` on 2023-08-10 09:20:57
export PATH="$PATH:/home/adrian/.local/bin"
