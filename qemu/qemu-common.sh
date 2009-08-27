#!/bin/sh
# $Id: qemu-common.sh,v 1.3 2009-08-01 22:47:30 brian Exp $
# Copyright (c) 2009 by Brian Manning <elspicyjack at gmail dot com>

# script to help setup QEMU
UNAME=$(which uname)
QEMU_PID="qemu.pid"
KERNEL_VER="2.6.30.5"

# Test for a file argument; some scripts will want an initramfs image, others
# will want an ISO image

if [ "x$1" = "x" ]; then
    echo "ERROR: Missing script argument; either an initramfs or ISO image"
    exit 1
fi
if [ ! -e $1 ]; then
    echo "ERROR: File $1 doesn't exist"
    exit 1
fi 


# set up the QEMU binary location
OSDETECT=$($UNAME -s)
if [ "x$OSDETECT" == "xDarwin" ]; then
    # Mac path
    QEMU_BIN="/Applications/Apps/Q-0.9.1d118.app/Contents"
    QEMU_BIN="$QEMU_BIN/MacOS/i386-softmmu.app/Contents/MacOS/i386-softmmu"
elif [ ${OSDETECT} == "Linux" ]; then
    # Linux path
    QEMU_BIN="/usr/local/bin/qemu"
else
    echo "ERROR: Unknown OS Type.  Exiting..."
    exit 1
fi
export QEMU_BIN QEMU_PID KERNEL_VER
