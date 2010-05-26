# Paul @ MoDaCo's Dropbear password setup and launch file

# Only define a password if we don't have one yet

mkdir /data/dropbear

if [ ! -f "/data/dropbear/passwd" ]
then
	`< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c6>/data/dropbear/passwd`
fi

# Temporarily mount system RW so we can edit the build prop
mount -o rw,remount -t yaffs2 /dev/block/mtdblock3 /system

rm /system/build.prop
passwd=`cat /data/dropbear/passwd`
cat /system/build.prop.nopassword|sed -e "s/REBOOT REQUIRED/SSH password: $passwd/">/system/build.prop

mount -o ro,remount -t yaffs2 /dev/block/mtdblock3 /system
# All done, system mounted ro again

# Reboot to ensure build.prop is picked up
#`/system/xbin/busybox reboot -f`

if [ ! -f "/data/dropbear/rsa_host_key" ]
then
	dropbearkey -t rsa -f /data/dropbear/rsa_host_key
fi

if [ ! -f "/data/dropbear/dss_host_key" ]
then
	dropbearkey -t dss -f /data/dropbear/dss_host_key
fi

passwd=`cat /data/dropbear/passwd`

dropbear -A -N root -U 0 -G 0 -C "$passwd" -d /data/dropbear/dss_host_key -r /data/dropbear/rsa_host_key -p 2222
