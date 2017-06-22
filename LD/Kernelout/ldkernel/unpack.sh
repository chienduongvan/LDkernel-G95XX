#!/sbin/sh
# ========================================
# script LDkerel
# ========================================
# Created by chienduongvan

val1=$1

        case $val1 in
        	1)
		  BOOT="dream2lte.img"
        	  ;;
        	2)
		  BOOT="dreamlte.img"
        	  ;;
        esac

echo "unpack $BOOT"
mv -f /tmp/"$BOOT" /tmp/AIK/boot.img

cd /tmp/AIK
chmod 755 unpackimg.sh;
./unpackimg.sh boot.img
rm -f boot.img

