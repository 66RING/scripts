PADDING=$(bspc config bottom_padding)
EXIST=$(pgrep polybar)

bspc config bottom_padding $PADDING
bspc config top_padding $PADDING
bspc config right_padding $PADDING
bspc config left_padding $PADDING

if [ $EXIST ]; then
  polybar-msg cmd toggle > /dev/null
fi

