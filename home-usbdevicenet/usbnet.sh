#!/bin/sh
cd /home/urjaman
echo "device" > /sys/kernel/debug/ff580000.usb/cur_mode
modprobe g_ether
sleep 1
ip link set usb0 up
ip a add 192.168.42.5/24 dev usb0
if [ -f /tmp/usbnet-dhcpd.pid ]; then
	kill -KILL $(cat /tmp/usbnet-dhcpd.pid)
	rm /tmp/usbnet-dhcpd.pid
fi
rm -f /tmp/dummylease
busybox udhcpd usbnet-dhcpd.conf
