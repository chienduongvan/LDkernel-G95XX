#!/sbin/sh

ui_print " set build.prop"
cd /system

sed -i -e '/ro.securestorage.knox/c\ro.securestorage.knox=false' build.prop
sed -i -e '/ro.securestorage.support/c\ro.securestorage.support=false' build.prop
sed -i -e '/ro.config.knox/c\ro.config.knox=0' build.prop
sed -i -e '/ro.config.tima/c\ro.config.tima=0' build.prop
sed -i -e '/wlan.wfd.hdcp/c\wlan.wfd.hdcp=disable' build.prop

sync
