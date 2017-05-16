PREFIX="$HOME/.local"
echo PREFIX="$PREFIX"
LIBFFI_CFLAGS="-I$PREFIX/lib/libffi-3.2/include"
echo LIBFFI_CFLAGS="$LIBFFI_CFLAGS"
LIBFFI_LIBS="-L$PREFIX/lib64 -lffi"
echo LIBFFI_LIBS="$LIBFFI_LIBS"
BDW_GC_CFLAGS="-I$PREFIX/include"
echo BDW_GC_CFLAGS="$BDW_GC_CFLAGS"
BDW_GC_LIBS="-L$PREFIX/lib -lgc $PREFIX/lib/libgc.so"
echo BDW_GC_LIBS="$BDW_GC_LIBS"
export LIBFFI_CFLAGS
export LIBFFI_LIBS
export BDW_GC_CFLAGS
export BDW_GC_LIBS

echo "../configure --prefix=$PREFIX CPPFLAGS=\"-I$PREFIX/include\" LDFLAGS=\"-L$PREFIX/lib\" --disable-silent-rules"
../configure --prefix=$PREFIX CPPFLAGS="-I$PREFIX/include" LDFLAGS="-L$PREFIX/lib" --disable-silent-rules

echo PREFIX="$PREFIX"
echo LIBFFI_CFLAGS="$LIBFFI_CFLAGS"
echo LIBFFI_LIBS="$LIBFFI_LIBS"
echo BDW_GC_CFLAGS="$BDW_GC_CFLAGS"
echo BDW_GC_LIBS="$BDW_GC_LIBS"
make