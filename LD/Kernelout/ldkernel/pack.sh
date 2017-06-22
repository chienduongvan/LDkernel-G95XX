#!/sbin/sh
# ========================================
# script LDkerel
# ========================================
# Created by chienduongvan

echo "pack boot.img"
cd /tmp/AIK

chmod 755 repackimg.sh;
./repackimg.sh

mv -f /tmp/AIK/image-new.img /tmp/boot.img
cd /tmp

#Remove SEANDROID ENFORCING Message
echo -n "SEANDROIDENFORCE" >> boot.img
