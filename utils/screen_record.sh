#!/bin/sh

w=2560
h=1600
x=0
y=0
fps=60
outfile=sc.mp4

ffmpeg \
	-f x11grab \
	-s $w'x'$h \
	-i "$DISPLAY+$x,$y" \
	-f alsa -i default \
	-r $fps -c:v h264 -crf 0 -preset ultrafast \
	-c:a aac \
	$outfile

