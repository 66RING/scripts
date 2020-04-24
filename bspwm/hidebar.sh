bspc config bottom_padding 2
if pgrep "polybar"; then
  polybar-msg cmd toggle
fi

