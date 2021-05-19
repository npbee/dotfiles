
# Updates editor information when the keymap changes.
function zle-keymap-select() {
  zle reset-prompt
  zle -R
}

zle -N zle-keymap-select

function vi_mode_prompt_info() {
  echo "${${KEYMAP/vicmd/[% NORMAL]%}/(main|viins)/[% INSERT]%}"
}

# define right prompt, regardless of whether the theme defined it
RPS1='$(vi_mode_prompt_info)'
RPS2=$RPS1

# Bind control+O for a temporary normal mode command
vi-cmd () {
  local REPLY

  zle .read-command -K vicmd &&
    zle $REPLY -K vicmd
}

zle -N vi-cmd
bindkey -v '^O' vi-cmd
