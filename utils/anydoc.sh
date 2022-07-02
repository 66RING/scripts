#!/bin/sh

# require:
#  texlive-core
#  texlive-langchinese
#  Source Han font

  # "pdf")
	# pandoc --pdf-engine=xelatex \
	# -N \
	# -V geometry:margin=1in \
	# -V CJKmainfont="Source Han Sans CN" \
	# -V fontsize=17pt \
	# -o ${SRC%.*}.pdf $SRC
	# ;;

TYPE=$1
SRC=$2

# 1. convert to html first for compatibility
# 2. convert to $1 actually

# 先转换成html是为了解析markdown中的图片
# 注意转换成html时自带了序号，所以pdf不需要-N
if [ $# -gt 0 ] ;then
  case "$TYPE"
  in
  # "pdf")
	# pandoc --pdf-engine=xelatex \
	# -N \
	# -V geometry:margin=1in \
	# -V CJKmainfont="Source Han Sans CN" \
	# -V fontsize=17pt \
	# -o ${SRC%.*}.pdf $SRC
	# ;;
  *)
	tmp="$(mktemp --suffix='.html')"
	pandoc "$SRC" -N -t html -o "$tmp"
	pandoc --pdf-engine=xelatex \
	  -V geometry:margin=1in \
	  -V CJKmainfont="Source Han Sans CN" \
	  -V fontsize=17pt \
	  "$tmp" -t $TYPE -o $(echo "$2" | cut -d '.' -f 1)".$TYPE"
	rm "$tmp"
	;;
  esac
else
  echo -e "Usage:\n\tosdoc <output_type> <input_file>"
fi
