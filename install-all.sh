#!/bin/bash
clear
echo install-all
#Install all the necessities to download and install a
#requirement-free package.
PREFIX=$HOME/.local
#Help with building guile
#Uncomment if pkg-config doesn't autodetect libgc and libffi.
#PKG_CONFIG_PATH="$PREFIX"lib/pkgconfig:"$PREFIX"lib64/pkgconfig

#for future reference:
#list of packages:
#M4
#Bison
#bash
#libtool
#libgmp
#autoconf
#libatomic_ops
#bdw-gc
#guile
#wget
#autogen
#libnettle
#gnutls
#coreutils
#tar
#gzip
#bz2
#xz
#lzip
#make
#gcc

#URLS:
M4_URL=http://ftp.gnu.org/gnu/m4/m4-1.4.18.tar.xz
BISON_URL=http://ftp.gnu.org/gnu/bison/bison-3.0.4.tar.xz
BASH_URL=http://ftp.gnu.org/gnu/bash/bash-4.4.tar.gz
LIBTOOL_URL=http://ftp.gnu.org/gnu/libtool/libtool-2.4.6.tar.xz
LZIP_URL=http://download.savannah.gnu.org/releases/lzip/lzip-1.18.tar.gz
LIBMPC_URL=ftp://ftp.gnu.org/gnu/mpc/mpc-1.0.3.tar.gz
LIBMPFR_URL=http://www.mpfr.org/mpfr-current/mpfr-3.1.5.tar.xz
LIBGMP_URL=https://gmplib.org/download/gmp/gmp-6.1.2.tar.lz
AUTOCONF_URL=http://ftp.gnu.org/gnu/autoconf/autoconf-2.69.tar.xz
GCC_URL=https://ftp.gnu.org/gnu/gcc/gcc-6.3.0/gcc-6.3.0.tar.gz
AUTOMAKE_URL=https://ftp.gnu.org/gnu/automake/automake-1.15.tar.xz
LIBATOMIC_OPS_URL=https://github.com/ivmai/libatomic_ops/archive/libatomic_ops-7_4_4.tar.gz
BDW_GC_URL=https://github.com/ivmai/bdwgc/archive/gc7_6_0.tar.gz
PKG_CONFIG_URL=https://pkg-config.freedesktop.org/releases/pkg-config-0.29.1.tar.gz
GUILE_URL=ftp://ftp.gnu.org/gnu/guile/guile-2.0.13.tar.lz
WGET_URL=http://ftp.gnu.org/gnu/wget/wget-1.18.tar.xz
AUTOGEN_URL=http://ftp.gnu.org/gnu/autogen/autogen-5.18.7.tar.xz
LIBNETTLE_URL=https://ftp.gnu.org/gnu/nettle/nettle-3.3.tar.gz
GNUTLS_URL=https://ftp.gnu.org/gnu/gnutls/gnutls-3.1.5.tar.lz
COREUTILS_URL=https://ftp.gnu.org/gnu/coreutils/coreutils-8.26.tar.xz
TAR_URL=https://ftp.gnu.org/gnu/tar/tar-1.29.tar.xz
GZIP_URL=https://ftp.gnu.org/gnu/gzip/gzip-1.8.tar.xz
BZ2_URL=http://www.bzip.org/1.0.6/bzip2-1.0.6.tar.gz
XZ_URL=http://tukaani.org/xz/xz-5.2.3.tar.xz
MAKE_URL=https://ftp.gnu.org/gnu/make/make-4.2.tar.gz

#DIRECTORIES:
M4_DIR=m4-1.4.18
BISON_DIR=bison-3.0.4
BASH_DIR=bash-4.4
LIBTOOL_DIR=libtool-2.4.6
LZIP_DIR=lzip-1.18
LIBMPC_DIR=mpc-1.0.3
LIBMPFR_DIR=mpfr-3.1.5
LIBGMP_DIR=gmp-6.1.2
AUTOCONF_DIR=autoconf-2.69
GCC_DIR=gcc-6.3.0
AUTOMAKE_DIR=automake-1.15
LIBATOMIC_OPS_DIR=libatomic_ops-libatomic_ops-7_4_4
BDW_GC_DIR=bdwgc-gc7_6_0
PKG_CONFIG_DIR=pkg-config-0.29.1
GUILE_DIR=guile-2.0.13
WGET_DIR=wget-1.18
AUTOGEN_DIR=autogen-5.18.7
LIBNETTLE_DIR=nettle-3.3
GNUTLS_DIR=gnutls-3.1.5
COREUTILS_DIR=coreutils-8.26
TAR_DIR=tar-1.29
GZIP_DIR=gzip-1.8
BZ2_DIR=bzip2-1.0.6
XZ_DIR=xz-5.2.3
MAKE_DIR=make-4.2



#=======================================================================
function announce()
{
	echo $@
	echo $@>&2
}

function separator()
{
	announce =======================================================================
}

#*.tar.bz2
function extract_bz2()
{
    echo extract_bz2
    echo "$@"
    tar --extract --bzip2 #--verbose $@
}

#*.tar.gz
function extract_gz()
{
    echo extract_gz
    echo "$@"
    tar --extract --gzip #--verbose $@
}

#*.tar.lz
function extract_lz()
{
    echo extract_lz
    echo "$@"
    tar --extract --lzip #--verbose $@
}

#*.tar.xz
function extract_xz()
{
    echo extract_xz
    echo "$@"
    tar --extract --xz #--verbose $@
}

function downloadToSTDOUT()
{
    echo downloadToSTDOUT >&2
    echo "$@" >&2
    wget --quiet --output-document=- $@
}

function downloadAndExtractAny()
{
	echo "downloadAndExtractAny $@" >&2
	#Get file extension of entire argument list with sed.
	extension=$(echo "$@" | sed "s/.*\././" )
	announce "extension: $extension"
	case $extension in
	.bz2)
		 downloadToSTDOUT $@ | extract_bz2;;
	.gz)
		downloadToSTDOUT $@ | extract_gz;;
	.lz)
		downloadToSTDOUT $@ | extract_lz;;
	.xz)
		downloadToSTDOUT $@ | extract_xz;;
	*)
		echo Error: unrecognized extension "$extension" >&2
		exit 1;;
	esac
	echo extraction complete.
}

function makeCycle()
{
    announce beginning make.
    make
    announce done with make.
    announce beginning check.
    make check
    announce done with check.
    announce beginning test.
    make test
    announce done with test.
    announce beginning install.
    make install
    announce done with install.
}
#=======================================================================
#for future reference:
#list of packages:
#M4
#Bison
#bash
#libtool
#libmpc
#libmpfr
#libgmp
#autoconf
#libatomic_ops
#bdw-gc
#guile
#wget
#autogen
#libnettle
#gnutls
#coreutils
#tar
#gzip
#bz2
#xz
#lzip
#make
#gcc

function getAndMakeM4()
{
	separator
    announce making m4
	mkdir --verbose $M4_DIR
	downloadAndExtractAny $M4_URL
	#exit 1
    #downloadToSTDOUT $M4_URL | extract_xz
    cd $M4_DIR
    mkdir --verbose build_dir
    cd build_dir
	../configure --help
    ../configure --prefix="$PREFIX" --disable-silent-rules
    makeCycle
    cd ../../
#    rm --recursive --force --verbose $M4_DIR
    rm --recursive --force $M4_DIR
}
function getAndMakeBision()
{
	separator
    announce making bision
	mkdir --verbose $BISON_DIR
	downloadAndExtractAny $BISON_URL
    #downloadToSTDOUT $BISON_URL | extract_xz
    cd $BISON_DIR
    mkdir --verbose build_dir
    cd build_dir
	../configure --help
    ../configure --prefix="$PREFIX" --disable-silent-rules
    makeCycle
    cd ../../
#    rm --recursive --force --verbose $BISON_DIR
    rm --recursive --force $BISON_DIR
}
function getAndMakeBash()
{
	separator
	announce making bash
	mkdir --verbose $BASH_DIR
	downloadAndExtractAny $BASH_URL
    #downloadToSTDOUT $BASH_URL | extract_gz
    cd $BASH_DIR
    mkdir --verbose build_dir
    cd build_dir
	../configure --help
    ../configure --prefix="$PREFIX" --disable-silent-
    makeCycle
    cd ../../
#    rm --recursive --force --verbose $BASH_DIR
    rm --recursive --force $BASH_DIR
}
function getAndMakeLibtool()
{
	separator
    announce making Libtool
    mkdir --verbose $LIBTOOL_DIR
    downloadAndExtractAny $LIBTOOL_URL
    #downloadToSTDOUT $LIBTOOL_URL | extract_xz
    cd $LIBTOOL_DIR
    mkdir --verbose build_dir
    cd build_dir
    pwd
	../configure --help
    ../configure --prefix="$PREFIX" --disable-silent-rules
    makeCycle
    cd ../../
#    rm --recursive --force --verbose $LIBTOOL_DIR
    rm --recursive --force $LIBTOOL_DIR
}
function getAndMakeLzip()
{
	separator
    announce making Lzip
    mkdir --verbose $LZIP_DIR
    downloadAndExtractAny $LZIP_URL
    #downloadToSTDOUT $LZIP_URL | extract_gz
    cd $LZIP_DIR
    mkdir --verbose build_dir
    cd build_dir
	../configure --help
    ../configure --prefix="$PREFIX" --disable-silent-rules
    makeCycle
    cd ../../
#    rm --recursive --force --verbose $LZIP_DIR
    rm --recursive --force $LZIP_DIR
}
function getAndMakeLibgmp()
{
	separator
    announce making LibGMP
    mkdir --verbose $LIBGMP_DIR
    downloadAndExtractAny $LIBGMP_URL
    #downloadToSTDOUT $LIBGMP_URL | extract_lz
    cd $LIBGMP_DIR
    mkdir --verbose build_dir
    cd build_dir
	../configure --help
    ../configure --prefix="$PREFIX" --disable-silent-rules
    makeCycle
    cd ../../
#    rm --recursive --force --verbose $LIBGMP_DIR
    rm --recursive --force $LIBGMP_DIR
}
function getAndMakeLibmpfr()
{
	separator
    announce making LibMPFR
    mkdir --verbose $LIBMPFR_DIR
    downloadAndExtractAny $LIBMPFR_URL
    #downloadToSTDOUT $LIBMPFR_URL | extract_lz
    cd $LIBMPFR_DIR
    mkdir --verbose build_dir
    cd build_dir
	../configure --help
    ../configure --prefix="$PREFIX" --disable-silent-rules --with-gmp="$PREFIX"
    makeCycle
    cd ../../
#    rm --recursive --force --verbose $LIBMPFR_DIR
    rm --recursive --force $LIBMPFR_DIR
}
function getAndMakeLibmpc()
{
	separator
    announce making LibMPC
    mkdir --verbose $LIBMPC_DIR
    downloadAndExtractAny $LIBMPC_URL
    #downloadToSTDOUT $LIBMPC_URL | extract_lz
    cd $LIBMPC_DIR
    mkdir --verbose build_dir
    cd build_dir
	../configure --help
    ../configure --prefix="$PREFIX" --disable-silent-rules --with-gmp="$PREFIX" --with-mpfr="$PREFIX"
    makeCycle
    cd ../../
#    rm --recursive --force --verbose $LIBMPC_DIR
    rm --recursive --force $LIBMPC_DIR
}
function getAndMakeAutoconf()
{
	separator
    announce making autoconf
    pwd
    mkdir --verbose $AUTOCONF_DIR
    pwd
    downloadAndExtractAny $AUTOCONF_URL
    pwd
    #downloadToSTDOUT $AUTOCONF_URL | extract_xz
    cd $AUTOCONF_DIR
    pwd
    mkdir --verbose build_dir
    pwd
    cd build_dir
    pwd
	../configure --help
    pwd
    ../configure --prefix="$PREFIX" --disable-silent-rules
    pwd
    makeCycle
    pwd
    cd ../../
    pwd
#    rm --recursive --force --verbose $AUTOCONF_DIR
}
function getAndMakeGCC()
{
	separator
    announce making gcc
#    pwd >&2
    echo making gcc >&2
#    pwd >&2
	mkdir --verbose $GCC_DIR
#    pwd >&2
	downloadAndExtractAny $GCC_URL
#    pwd >&2
    #downloadToSTDOUT $GCC_URL | extract_gz
    cd $GCC_DIR
#    pwd >&2
    mkdir --verbose build_dir
#    pwd >&2
    cd build_dir
#    pwd >&2
	../configure --help
#    pwd >&2
    ../configure --prefix="$PREFIX" --disable-silent-rules --with-gmp="$PREFIX" --with-mpc="$PREFIX" --with-mpfr="$PREFIX" --disable-multilib
#    pwd >&2
    makeCycle
#    pwd >&2
    cd ../../
#    pwd >&2
    #rm --recursive --force --verbose $GCC_DIR
}
function getAndMakeAutomake()
{
	separator
    announce making automake
    pwd
    mkdir --verbose $AUTOMAKE_DIR
    pwd
    downloadAndExtractAny $AUTOMAKE_URL
    #downloadToSTDOUT $AUTOMAKE_URL | extract_xz
    pwd
    cd $AUTOMAKE_DIR
    pwd
    mkdir --verbose build_dir
    pwd
    cd build_dir
    pwd
	../configure --help
    pwd
    ../configure --prefix="$PREFIX" --disable-silent-rules
    pwd
    makeCycle
    pwd
    cd ../../
#    rm --recursive --force --verbose $AUTOMAKE_DIR
}
function getAndMakeLibAtomic_ops()
{
	separator
    pwd
    announce making libatomic_ops
    pwd
    mkdir --verbose $LIBATOMIC_OPS_DIR
    pwd
    downloadAndExtractAny $LIBATOMIC_OPS_URL
    #downloadToSTDOUT $LIBATOMIC_OPS_URL | extract_gz
    pwd
    cd $LIBATOMIC_OPS_DIR
    #Necessary for LibAtomic
    pwd
    announce begin autoreconfig LibAtomic_Ops...
    pwd
    autoreconf --verbose  --install --force
    pwd
    announce end autoreconfig LibAtomic_Ops...
    pwd
    announce begin automake LibAtomic_Ops
    pwd
    automake --add-missing
    pwd
    announce end automake LibAtomic_Ops...
    pwd
    
    mkdir --verbose build_dir
    pwd
    cd build_dir
    pwd
	../configure --help
    pwd
    ../configure --prefix="$PREFIX" --disable-silent-rules
    pwd
    makeCycle
    pwd
    cd ../../
    pwd
#    rm --recursive --force --verbose $LIBATOMIC_OPS_DIR
}
function getAndMakeGC()
{
	separator
    pwd
    announce making gc
    pwd
    mkdir --verbose $BDW_GC_DIR
    pwd
    downloadAndExtractAny $BDW_GC_URL
    #downloadToSTDOUT $BDW_GC_URL | extract_gz
    pwd
	echo $BDW_GC_DIR
    pwd
    cd $BDW_GC_DIR
    pwd
    mkdir --verbose build_dir
    pwd
    cd build_dir
    pwd
	../configure --help
    pwd
    ../configure --prefix="$PREFIX" --disable-silent-rules
    pwd
    makeCycle
    pwd
    cd ../../
    pwd
#    rm --recursive --force --verbose $BDW_GC_DIR
}
function getAndMakePkg_Config()
{
	separator
    pwd
    announce making Guile
    pwd
    mkdir --verbose $PKG_CONFIG_DIR
    pwd
    downloadAndExtractAny $PKG_CONFIG_URL
    #downloadToSTDOUT $GUILE_URL | extract_xz
    pwd
    cd $GUILE_PKG_CONFIG_DIR
    pwd
    mkdir --verbose build_dir
    pwd
    cd build_dir
    pwd
	../configure --help
    pwd
    ../configure --prefix="$PREFIX" --disable-silent-rules
    pwd
    makeCycle
    pwd
    cd ../../
#    rm --recursive --force --verbose $PKG_CONFIG_DIR
}
function getAndMakeGuile()
{
	separator
    announce making Guile
    mkdir --verbose $GUILE_DIR
    downloadAndExtractAny $GUILE_URL
    #downloadToSTDOUT $GUILE_URL | extract_xz
    cd $GUILE_DIR
    mkdir --verbose build_dir
    cd build_dir
	../configure --help
    ../configure --prefix="$PREFIX" --disable-silent-rules
    makeCycle
    cd ../../
#    rm --recursive --force --verbose $GUILE_DIR
}
function getAndMakewget()
{
	separator
    announce making wget
    mkdir --verbose $WGET_DIR
    downloadAndExtractAny $WGET_URL
    #downloadToSTDOUT $WGET_URL | extract_xz
    cd $WGET_DIR
    mkdir --verbose build_dir
    cd build_dir
	../configure --help
    ../configure --prefix="$PREFIX" --disable-silent-rules
    makeCycle
    cd ../../
#    rm --recursive --force --verbose $WGET_DIR
}
function getAndMakeAutogen()
{
	separator
    announce making autogen
    mkdir --verbose $AUTOGEN_DIR
    downloadAndExtractAny $AUTOGEN_URL
    #downloadToSTDOUT $AUTOGEN_URL | extract_xz
    cd $AUTOGEN_DIR
    mkdir --verbose build_dir
    cd build_dir
	../configure --help
    ../configure --prefix="$PREFIX" --disable-silent-rules
    makeCycle
    cd ../../
#    rm --recursive --force --verbose $AUTOGEN_DIR
}
function getAndMakeLibNettle()
{
	separator
    announce making LibNettle
    mkdir --verbose $LIBNETTLE_DIR
    downloadAndExtractAny $LIBNETTLE_URL
    #downloadToSTDOUT $LIBNETTLE_URL | extract_xz
    cd $LIBNETTLE_DIR
    mkdir --verbose build_dir
    cd build_dir
	../configure --help
    ../configure --prefix="$PREFIX" --disable-silent-rules
    makeCycle
    cd ../../
#    rm --recursive --force --verbose $LIBNETTLE_DIR
}
function getAndMakeGnutls()
{
	separator
    announce making Gnutls
    mkdir --verbose $GNUTLS_DIR
    downloadAndExtractAny $GNUTLS_URL
    #downloadToSTDOUT $GNUTLS_URL | extract_xz
    cd $GNULTLS_DIR
    mkdir --verbose build_dir
    cd build_dir
	../configure --help
    ../configure --prefix="$PREFIX" --disable-silent-rules
    makeCycle
	cd ../../
#    rm --recursive --force --verbose $GNUTLS_DIR
}
function getAndMakeCoreUtils()
{
	separator
    announce making CoreUtils
    mkdir --verbose $COREUTISL_DIR
    downloadAndExtractAny $COREUTILS_URL
    #downloadToSTDOUT $COREUTILS_URL | extract_xz
    cd $COREUTILS_DIR
    mkdir --verbose build_dir
    cd build_dir
	../configure --help
    ../configure --prefix="$PREFIX" --disable-silent-rules
    makeCycle
    cd ../../
#    rm --recursive --force --verbose $COREUTILS_DIR
}
function getAndMakeTar()
{
	separator
    announce making tar
    mkdir --verbose $TAR_DIR
    downloadAndExtractAny $TAR_URL
    #downloadToSTDOUT $TAR_URL | extract_xz
    cd $TAR_DIR
    mkdir --verbose build_dir
    cd build_dir
	../configure --help
    ../configure --prefix="$PREFIX" --disable-silent-rules
    makeCycle
    cd ../../
#    rm --recursive --force --verbose $TAR_DIR
}
function getAndMakegz()
{
	separator
    announce making gz
    mkdir --verbose $GZIP_DIR
    downloadAndExtractAny $GZIP_URL
    #downloadToSTDOUT $GZIP_URL | extract_xz
    cd $GZIP_DIR
    mkdir --verbose build_dir
    cd build_dir
	../configure --help
    ../configure --prefix="$PREFIX" --disable-silent-rules
    makeCycle
    cd ../../
#    rm --recursive --force --verbose $GZIP_DIR
}
function getAndMakebz2()
{
	separator
    announce making bz2
    mkdir --verbose $BZ2_DIR
    downloadAndExtractAny $BZ2_URL
    #downloadToSTDOUT $BZ2_URL | extract_xz
    cd $BZ2_DIR
    mkdir --verbose build_dir
    cd build_dir
	../configure --help
    ../configure --prefix="$PREFIX" --disable-silent-rules
    makeCycle
    cd ../../
#    rm --recursive --force --verbose $BZ2_DIR
}
function getAndMakeXz()
{
	separator
    announce making xz
    mkdir --verbose $XZ_DIR
    downloadAndExtractAny $XZ_URL
    #downloadToSTDOUT $XZ_URL | extract_xz
    cd $XZ_DIR
    mkdir --verbose build_dir
    cd build_dir
	../configure --help
    ../configure --prefix="$PREFIX" --disable-silent-rules
    makeCycle
	cd ../../
#    rm --recursive --force --verbose $XZ_DIR
}
function getAndMakeMake()
{
	separator
    announce making make
    mkdir --verbose $MAKE_DIR
    downloadAndExtractAny $MAKE_URL
    #downloadToSTDOUT $MAKE_URL | extract_gz
    cd $MAKE_DIR
    mkdir --verbose build_dir
    cd build_dir
	../configure --help
	../configure --prefix="$PREFIX" --disable-silent-rules
    makeCycle
    cd ../../
#    rm --recursive --force --verbose $MAKE_DIR
}
#=======================================================================

#=======================================================================
function main()
{
	mkdir .logs
	#M4
	#50.321s real time
	announce M4...
	time getAndMakeM4 >.logs/M4.log 2>.logs/M4.err
	#sleep 10
    separator
    
    
    #Bison
    #39.070s real time
    announce Bison...
    time getAndMakeBision >.logs/Bison.log 2>.logs/Bison.err
    #sleep 10
    separator
	
	
    #Bash
    #6m 1.552s real time
    announce Bash...
    time getAndMakeBash >.logs/Bash.log 2>.logs/Bison.err
    #sleep 10
    separator
	
    
    #LibTool
    #a few errors result.
    #3m 52.604s real time
    announce Libtool...
    time getAndMakeLibtool >.logs/Libtool.log 2>.logs/Libtool.err
    #sleep 10
    separator
	
    
    #Lzip
    #10.080s real time
    announce Lzip...
    time getAndMakeLzip >.logs/Lzip.log 2>.logs/Lzip.err
    #sleep 10
    separator
	
	
    #libgmp
	#compiler warning:
	#
	#../../printf/repl-vsnprintf.c:396:0: warning: ISO C forbids an empty translation unit [-Wpedantic]
	# #endif /* ! HAVE_VSNPRINTF */
    #
    #2m 26.720s real time
    announce Libgmp...
    time getAndMakeLibgmp >.logs/Libgmp.log 2>.logs/Libgmp.err
    #sleep 10
    separator
	
    
    #libmpfr
    announce Libmpfr...
    time getAndMakeLibmpfr >.logs/Libmpfr.log 2>.logs/Libmpfr.err
    #sleep 10
    separator
	
    
    #libmpc
	#../../tests/tio_str.c:24:0: warning: "_POSIX_C_SOURCE" redefined
	# #define _POSIX_C_SOURCE 1 /* apparently needed on Darwin */
	# 
	#In file included from /usr/include/stdio.h:27:0,
	#				 from ../../tests/mpc-tests.h:25,
	#				 from ../../tests/tio_str.c:21:
	#/usr/include/features.h:225:0: note: this is the location of the previous definition
	# # define _POSIX_C_SOURCE 200809L
	# 
    announce Libmpc...
    time getAndMakeLibmpc >.logs/Libmpc.log 2>.logs/Libmpc.err
    #sleep 10
    separator
	
    
    #autoconf
    #ERROR: 451 tests were run,
	#6 failed (4 expected failures).
	#52 tests were skipped.
	#
    #6m 33.324s real time
    announce autoconf...
    time getAndMakeAutoconf >.logs/autoconf.log 2>.logs/autoconf.err
    #sleep 10
    separator
	
	

    #gcc
    announce gcc...
    time getAndMakeGCC	#>.logs/gcc.log 2>.logs/gcc.err
    #sleep 10
    separator
    pwd
	
	
    #automake
    #10.604s real time
    pwd
    announce automake...
    time getAndMakeAutomake #>.logs/automake.log 2>.logs/automake.err
    #sleep 10
    separator
    pwd
	
	
    #LibAtomic_Ops
    #12.009s real time
    pwd
    announce LibAtomic_Ops...
    time getAndMakeLibAtomic_ops #>.logs/atomic_ops.log 2>.logs/atomic_ops.err
    #sleep 10
    separator
	pwd
	

	
    #LibGC
    #8.490s real time
    pwd
    announce gc...
    time getAndMakeGC #>.logs/gc.log 2>.logs/gc.err
    #sleep 10
    separator    
	pwd
	
	
    #pkg-config
    #11.310s real time
    pwd
    announce pkg-config
    time getAndMakePkg_Config #>.logs/pkg_config.log 2>.logs/pkg_config.err
    #sleep 10
    separator
	pwd
	
	exit
	
    #Guile
    #m s real time
    announce Guile...
    time getAndMakeGuile >.logs/guile.log 2>.logs/guile.err
    #sleep 10
    
	exit
	
    #wget
    #m s real time
    announce wget...
    time getAndMakewget >.logs/wget.log 2>.logs/wget.err
    #sleep 10
    
	exit
    
    #autogen
    #m s real time
    announce autogen...
    time getAndMakeAutogen >.logs/Autogen.log 2>.logs/autogen.err
    #sleep 10
    
	exit
	
    #LibNettle
    #m s real time
    announce LibNettle...
    time getAndMakeLibNettle >.logs/libnettle.log 2>.logs/libnettle.err
    #sleep 10
    
	exit
	
    #GNUtls
    #m s real time
    announce Gnutls...
    time getAndMakeGnutls >.logs/gnutls.log 2>.logs/gnutls.err
    #sleep 10
    
	exit
	
    #CoreUtils
    #m s real time
    announce CoreUtils...
    time getAndMakeCoreUtils >.logs/coreutils.log 2>.logs/coreutils.err
    #sleep 10
    
	exit
	
    #tar
    #m s real time
    announce Tar...
    time getAndMakeTar >.logs/tar.log 2>.logs/tar.err
    #sleep 10
    
	exit
	
    #gz
    #m s real time
    announce gz...
    time getAndMakegz >.logs/gz.log 2>.logs/gz.err
    #sleep 10
    
	exit
    
    #bz2
    #m s real time
    announce bz2...
    time getAndMakebz2 >.logs/bz2.log 2>.logs/bz2.err
    #sleep 10
    
	exit
    
    #xz
    #m s real time
    announce xz...
    time getAndMakeXz >.logs/xz.log 2>.logs/xz.err
    #sleep 10
    
	exit
    
    #make
    #m s real time
    announce make...
    time getAndMakeMake >.logs/make.log 2>.logs/make.err
    #sleep 10
    
	exit
    
    #gcc
    #m s real time
    announce gcc...
    time getAndMakeGCC >.logs/gcc.log 2>.logs/gcc.err
    #sleep 10
    separator
	announce "concatinating logs..."
	separator
	
	exit
	
	pwd
	#cat .logs/{M4,Bison}.log > ./stdout.log
	# >out.log
	#cat .logs/{M4,Bison,Libtool,Lzip,Libgmp,autoconf,automake,atomic_ops,gc,pkg_config}.err > ./stderr.log
	# >err.log
	
	
	cat .logs/{M4,Bison,Bash,Libtool,Lzip,Libgmp,autoconf,automake,atomic_ops,gc,pkg_config}.log > ./stdout.log
	# >out.log
	cat .logs/{M4,Bison,Libtool,Lzip,Libgmp,autoconf,automake,atomic_ops,gc,pkg_config}.err > ./stderr.log
	# >err.log
    
#    cat .logs/{M4,Bison,Bash,Libtool,Lzip,Libgmp,autoconf,automake,atomic_ops,gc,pkg_config,guile,wget,autogen,libnettle,gnutls,coreutils,tar,gz,bz2,xz,make,gcc}.log>out.log
#    cat .logs/{M4,Bison,Bash,Libtool,Lzip,Libgmp,autoconf,automake,atomic_ops,gc,pkg_config,guile,wget,autogen,libnettle,gnutls,coreutils,tar,gz,bz2,xz,make,gcc}.err>err.log
#    rm -rvf .logs
#    cat .logs/*.err>error.log
#    cat .logs/*.log>out.log
}
#=======================================================================

time main > main.log 2> main.err
#rm -rvf /home/spim/.local
announce done
