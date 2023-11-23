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

while getopts 'nmt:s:c:h' opt; do
  case "$opt" in
    n)
	  FLAGS+=" -N "
      ;;

    m)
	  FLAGS+=" --webtex "
      ;;

    t)
      TYPE="$OPTARG"
      ;;

    s)
      SRC="$OPTARG"
      ;;

    c)
      arg="$OPTARG"
      ;;
   
    ?|h)
      echo "Usage: $(basename $0) [-n] [-m] [-t target_type] [-s input_file]"
      exit 1
      ;;
  esac
done

# 1. convert to html first for compatibility
# 2. convert to $1 actually

# 先转换成html是为了解析markdown中的图片
# 注意转换成html时自带了序号，所以pdf不需要-N
if [ $# -gt 0 ] ;then
  case "$TYPE"
  in
  *)
	# cheat sheet
	# -V colorlinks=true \
	# -V linkcolor=blue \
	# -V urlcolor=blue \
	# -V toccolor=gray \
	tmp="$(mktemp --suffix='.html')"
	pandoc "$SRC" $FLAGS -t html -o "$tmp"
	pandoc --pdf-engine=xelatex \
	  -V colorlinks=true \
	  -V geometry:margin=1in \
	  -V CJKmainfont="Source Han Sans CN" \
	  -V fontsize=17pt \
	  "$tmp" -t $TYPE -o $(echo "$SRC" | cut -d '.' -f 1)".$TYPE"
	rm "$tmp"
	;;
  esac
else
  echo -e "Usage:\n\tosdoc <output_type> <input_file>"
fi
