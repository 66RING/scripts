#!/bin/sh

_target="powerpc-linux-gnu"
_host="x86_64-linux-gnu"
_prefix="/home/ring/var/gcc-9.1.0/build"

../configure -v \
  --build=${_host} \
  --host=${_host} \
  --target=${_target} \
  --prefix=${_prefix} \
  --enable-checking=release \
  --enable-languages=c,c++ \
  --disable-multilib \
  --disable-werror \
  --program-suffix=${_target}- \

