PADDING=$(bspc config bottom_padding)

bspc config bottom_padding $PADDING
bspc config top_padding $PADDING

if pgrep "polybar"; then
  polybar-msg cmd toggle
fi

