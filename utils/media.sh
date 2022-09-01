# $1=inputfile
# $2=outputfile
# $3=text
function gen_cover {
  inputfile=$1
  outputfile=$2
  text=$3
  tmpblur=/tmp/tmpblur.jpg
  convert -blur 0x80 $inputfile $tmpblur
  convert -interline-spacing 20 \
	-pointsize 120 -gravity center \
	-fill '#fdf6e3' -stroke '#fdf6e3' -strokewidth 40 \
	-annotate +0+0 "$text"\
	-fill '#000000' -stroke '#000000' -strokewidth 0 \
	-annotate +0+0 "$text"\
	$tmpblur $outputfile
}

gen_cover /home/ring/11.png /home/ring/12.png hello
