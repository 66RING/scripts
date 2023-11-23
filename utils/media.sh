SC_FONT=${SC_FONT:-'WenQuanYi-Micro-Hei'}

# $1=inputfile
# $2=outputfile
# $3=text
# $4=font_size
function gen_cover {
  inputfile=$(realpath $1)
  [ ! -f $inputfile ] && echo "$inputfile not exist" && exit 1
  outputfile=$(realpath $2)
  [ $inputfile == $outputfile ] && echo "you may not want to cover the original file" && exit 1
  text=$3
  font_size=${4:-250}

  tmpblur=/tmp/tmpblur.jpg
  [ -f $tmpblur ] && rm $tmpblur
  convert -blur 0x30 $inputfile $tmpblur
  convert -interline-spacing 20 \
	-pointsize $font_size -font "$SC_FONT" \
	-gravity center \
	-fill '#fdf6e3' -stroke '#fdf6e3' -strokewidth 40 \
	-annotate +0+0 "$text"\
	-fill '#000000' -stroke '#000000' -strokewidth 0 \
	-annotate +0+0 "$text"\
	$tmpblur $outputfile
}

gen_cover "$1" "$2" "$3" "$4"
