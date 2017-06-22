#!/system/bin/sh
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Busybox
if [ -e /su/xbin/busybox ]; then
	BB=/su/xbin/busybox;
else if [ -e /sbin/busybox ]; then
	BB=/sbin/busybox;
else
	BB=/system/xbin/busybox;
fi;
fi;

# Mount
$BB mount -t rootfs -o remount,rw rootfs;
$BB mount -o remount,rw /system;
$BB mount -o remount,rw /data;
$BB mount -o remount,rw /;

# init.d support
if [ ! -e /system/etc/init.d ]; then
	mkdir /system/etc/init.d
	chown -R root.root /system/etc/init.d
	chmod -R 755 /system/etc/init.d
fi

# start init.d
for FILE in /system/etc/init.d/*; do
	sh $FILE >/dev/null
done;

# Knox set to 0 on running system
/sbin/resetprop -n ro.boot.warranty_bit "0"
/sbin/resetprop -n ro.warranty_bit "0"

# Fix safetynet flags
/sbin/resetprop -n ro.boot.veritymode "enforcing"
/sbin/resetprop -n ro.boot.verifiedbootstate "green"
/sbin/resetprop -n ro.boot.flash.locked "1"
/sbin/resetprop -n ro.boot.ddrinfo "00000001"

# Samsung related flags
/sbin/resetprop -n ro.fmp_config "1"
/sbin/resetprop -n ro.boot.fmp_config "1"
/sbin/resetprop -n sys.oem_unlock_allowed "0"

# WakeUp Parameter
 	chmod 644 /sys/module/wakeup/parameters/enable_sensorhub_wl
 	echo N > /sys/module/wakeup/parameters/enable_sensorhub_wl
	chmod 644 /sys/module/wakeup/parameters/enable_ssp_wl
	echo N > /sys/module/wakeup/parameters/enable_ssp_wl
	chmod 644 /sys/module/wakeup/parameters/enable_bcmdhd4359_wl
	echo N > /sys/module/wakeup/parameters/enable_bcmdhd4359_wl
	chmod 644 /sys/module/wakeup/parameters/enable_wlan_wake_wl
	echo N > /sys/module/wakeup/parameters/enable_wlan_wake_wl
	chmod 644 /sys/module/wakeup/parameters/enable_bluedroid_timer_wl
	echo N > /sys/module/wakeup/parameters/enable_bluedroid_timer_wl
	chmod 644 /sys/module/wakeup/parameters/enable_mmc0_detect_wl
	echo N > /sys/module/wakeup/parameters/enable_mmc0_detect_wl
	chmod 644 /sys/module/wakeup/parameters/enable_wlan_ctrl_wake_wl
	echo N > /sys/module/wakeup/parameters/enable_wlan_ctrl_wake_wl
	chmod 644 /sys/module/wakeup/parameters/enable_wlan_rx_wake_wl
	echo N > /sys/module/wakeup/parameters/enable_wlan_rx_wake_wl
	chmod 644 /sys/module/wakeup/parameters/enable_wlan_wd_wake_wl
	echo N > /sys/module/wakeup/parameters/enable_wlan_wd_wake_wl

# Set I/O Scheduler tweaks mmcblk0
	chmod 644 /sys/block/mmcblk0/queue/scheduler
	echo maple > /sys/block/mmcblk0/queue/scheduler
	echo 512 > /sys/block/mmcblk0/queue/read_ahead_kb

# Set I/O Scheduler tweaks sda
  chmod 644 /sys/block/sda/queue/scheduler
	echo maple > /sys/block/sda/queue/scheduler
	echo 256 > /sys/block/sda/queue/read_ahead_kb

# Set I/O Scheduler tweaks sdb
	chmod 644 /sys/block/sdb/queue/scheduler
  echo deadline > /sys/block/sdb/queue/scheduler

# Set I/O Scheduler tweaks sdc
	chmod 644 /sys/block/sdc/queue/scheduler
	echo deadline > /sys/block/sdc/queue/scheduler

# Set I/O Scheduler tweaks sdd
	chmod 644 /sys/block/sdd/queue/scheduler
	echo deadline > /sys/block/sdd/queue/scheduler

# Enable FSYNC
	echo "N" > /sys/module/sync/parameters/fsync_enabled

# Don't treat storage as rotational
	echo 0 > /sys/block/mmcblk0/queue/rotational
	echo 0 > /sys/block/loop0/queue/rotational
	echo 0 > /sys/block/loop1/queue/rotational
	echo 0 > /sys/block/loop2/queue/rotational
	echo 0 > /sys/block/loop3/queue/rotational
	echo 0 > /sys/block/loop4/queue/rotational
	echo 0 > /sys/block/loop5/queue/rotational
	echo 0 > /sys/block/loop6/queue/rotational
	echo 0 > /sys/block/loop7/queue/rotational
	echo 0 > /sys/block/ram0/queue/rotational
	echo 0 > /sys/block/ram1/queue/rotational
	echo 0 > /sys/block/ram2/queue/rotational
	echo 0 > /sys/block/ram3/queue/rotational
	echo 0 > /sys/block/ram4/queue/rotational
	echo 0 > /sys/block/ram5/queue/rotational
	echo 0 > /sys/block/ram6/queue/rotational
	echo 0 > /sys/block/ram7/queue/rotational
	echo 0 > /sys/block/ram8/queue/rotational
	echo 0 > /sys/block/ram9/queue/rotational
	echo 0 > /sys/block/ram10/queue/rotational
	echo 0 > /sys/block/ram11/queue/rotational
	echo 0 > /sys/block/ram12/queue/rotational
	echo 0 > /sys/block/ram13/queue/rotational
	echo 0 > /sys/block/ram14/queue/rotational
	echo 0 > /sys/block/ram15/queue/rotational

# Deepsleep fix
su -c 'echo "temporary none" >> /sys/class/scsi_disk/0:0:0:0/cache_type'
su -c 'echo "temporary none" >> /sys/class/scsi_disk/0:0:0:1/cache_type'
su -c 'echo "temporary none" >> /sys/class/scsi_disk/0:0:0:2/cache_type'
su -c 'echo "temporary none" >> /sys/class/scsi_disk/0:0:0:3/cache_type'

# Unmount
$BB mount -t rootfs -o remount,rw rootfs;
$BB mount -o remount,ro /system;
$BB mount -o remount,rw /data;
$BB mount -o remount,ro /;

