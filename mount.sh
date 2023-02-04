#!/bin/sh

# 通过该命令查看被调用的参数
# echo "$@" >> /tmp/tmp-mount-usb-device.txt
# 目前被调用的参数形如：
#   -t exfat -o utf8,umask=000,uid=1024,gid=100 /dev/sdq1 /volumeUSB1/usbshare
# 可以认为是标准mount命令的参数。倒数第二个参数($5)是要挂载的设备，最后一个参数($6)是挂载点。

USB=$(echo "$@" | grep "volumeUSB")
#usb types
if [ -n "$USB" ]; then
    USBSYNC="/bin/usbsync.sh"
    #exfat partition
    if [ "$2" == "exfat" ]; then
        m=$(/bin/mount.bin | grep "$5")
        if [ -z "$m" ]; then
            MOUNTPOINT="$6"
            if [ ! -d "$MOUNTPOINT" ]; then
                mkdir -p "$MOUNTPOINT"
            fi
            /bin/mount.exfat-fuse "$5" "$MOUNTPOINT" -o nonempty
            if [ -f "$USBSYNC" ]; then
                "$USBSYNC" "$5" "$MOUNTPOINT" &
            fi
        fi
    #fat32 partition
    elif [ "$2" == "vfat" ]; then
        /bin/mount.bin "$@" &
        if [ -f "$USBSYNC" ]; then
            "$USBSYNC" "$5" "$6" &
        fi
    #others partition
    else
        /bin/mount.bin "$@"      
    fi
#other types
else
    /bin/mount.bin "$@"
fi
