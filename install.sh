#!/usr/bin/env bash

tmp_file="/bin/mount"
if [[ -f "${tmp_file}.bin" && -f "${tmp_file}" && ! -L "${tmp_file}" ]]
    echo Both ${tmp_file} and ${tmp_file}.bin files are exists, and ${tmp_file} is not a symbolic link.
    exit 1
fi

tmp_file="/usr/syno/bin/synocheckshare"
if [[ -f "${tmp_file}.bin" && -f "${tmp_file}" && ! -L "${tmp_file}" ]]
    echo Both ${tmp_file} and ${tmp_file}.bin files are exists, and ${tmp_file} is not a symbolic link.
    exit 1
fi

if [ -f /bin/mount.bin ]; then
    echo '/bin/mount.bin' already exists
else
    mv /bin/mount /bin/mount.bin
fi

if [ -f /usr/syno/bin/synocheckshare.bin ]; then
    echo /usr/syno/bin/synocheckshare.bin already exists 
else 
    mv /usr/syno/bin/synocheckshare /usr/syno/bin/synocheckshare.bin
fi

cp mount.sh /bin/mount.sh
cp synocheckshare.sh /usr/syno/bin/synocheckshare.sh


ln -sf "/bin/mount.sh" "/bin/mount"
ln -sf "/usr/syno/bin/synocheckshare.sh" "/usr/syno/bin/synocheckshare"
