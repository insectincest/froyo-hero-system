#!/system/bin/sh
# HikaRi

# Compcache
#delete old script if found
if [ -f /data/ramzswap.sh ]; then
  rm /data/ramzswap.sh
fi
#/system/xbin/insmod /system/lib/modules/xvmalloc.ko
#/system/xbin/insmod /system/lib/modules/ramzswap.ko disksize_kb=65536
#/system/xbin/swapon /dev/block/ramzswap0
#echo "10" > /proc/sys/vm/swappiness

#export HOME=/root
#export TERM=linux
