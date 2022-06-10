#!/bin/sh

# require:
#  texlive-core
#  texlive-langchinese
#  Source Han font

TYPE=$1
SRC=$2

# 1. convert to html first for compatibility
# 2. convert to $1 actually
if [ $# -gt 0 ] ;then
  case "$TYPE"
  in
  "pdf")
	pandoc --pdf-engine=xelatex \
	-N \
	-V geometry:margin=1in \
	-V CJKmainfont="Source Han Sans CN" \
	-V fontsize=17pt \
	-o ${SRC%.*}.pdf $SRC
	;;
  *)
	tmp="$(mktemp --suffix='.html')"
	pandoc "$SRC" -N -t html -o "$tmp"
	pandoc "$tmp" -t $TYPE -o $(echo "$2" | cut -d '.' -f 1)".$TYPE"
	rm "$tmp"
	;;
  esac
else
  echo -e "Usage:\n\tosdoc <output_type> <input_file>"
fi
