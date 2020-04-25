PADDING=$(bspc config bottom_padding)

bspc config bottom_padding $PADDING
if pgrep "polybar"; then
  polybar-msg cmd toggle
fi

