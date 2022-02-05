#!/bin/sh
# require:
#  texlive-core
#  texlive-langchinese
#  Source Han font
pandoc --pdf-engine=xelatex \
  -N \
  -V geometry:margin=1in \
  -V CJKmainfont="Source Han Sans CN" \
  -V fontsize=17pt \
  -o ${1%.*}.pdf $1 

