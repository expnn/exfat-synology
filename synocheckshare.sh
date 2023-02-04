#!/bin/sh

# 通过该命令查看被调用的参数
# echo "$@" >> /tmp/tmp-synocheckshare.txt
# 目前被调用的参数形如：
#   --vol-mounted USB /dev/sdq2 /volumeUSB1/usbshare1-2
#   --vol-unmounting USB /dev/sdq2 /volumeUSB1/usbshare1-2

if [ "$1" == "--vol-mounted" ]; then
    #m=$(fdisk -l | grep "$3" | grep "exFAT")
    m=$(df -Th "$3" | sed 1d | grep fuseblk)
    if [ -z "$m" ]; then
        /usr/syno/bin/synocheckshare.bin "$@"
    fi
else
    /usr/syno/bin/synocheckshare.bin "$@"
fi
