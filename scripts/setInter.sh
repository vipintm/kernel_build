#!/bin/bash
dmesg -c > /dev/null
dmesg -c > /dev/null
iwconfig > iwconfig.log
delInter=$(cat iwconfig.log | grep "IEEE 802.11" | cut -d" " -f1)
iw dev $delInter del
dmesg > dmesg_d.log
dmesg -c > /dev/null
dmesg -c > /dev/null
#noOfInter=$(cat iwconfig.log | grep "IEEE 802.11" | cut -d" " -f1 | wc -l)
interPhy=$(iw list | grep Wiphy | cut -d" " -f2)
iw phy $interPhy interface add mono0 type monitor
dmesg > dmesg_c.log
dmesg -c > /dev/null
dmesg -c > /dev/null
#iw dev mono0 set monitor plcpfail 
#dmesg > dmesg_f.log
#dmesg -c > /dev/null
#dmesg -c > /dev/null
#noOfInter=$(cat iwconfig.log | grep "IEEE 802.11" | cut -d" " -f1 | wc -l)
ifconfig mono0 up
sleep 5
dmesg > dmesg_u.log
dmesg -c > /dev/null
dmesg -c > /dev/null
