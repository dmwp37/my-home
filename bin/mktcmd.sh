#!/bin/bash
SHELL_PATH=`dirname $0`
SHELL_PATH=$SHELL_PATH/repo_dir
source $SHELL_PATH/precheck.env

$BSUB_CMD make -r -j 2 -f build/core/main.mk PRODUCT-$TARGET_PRODUCT-eng TOP=null ONE_SHOT_MAKEFILE=motorola/hal/mot_tcmd/tcmd/Android.mk BUILD_TINY_ANDROID=true TC_DEBUG=1 $CYGWIN_FLAG tcmd

cp out/target/product/$TARGET_PRODUCT/obj/EXECUTABLES/tcmd_intermediates/tcmd ~/tmp

