#!/bin/bash -x
# To insert the printk to generate the tree structure of kernel call code
# Vipin M

# Globel Conf

CONFF="gentree.det"
BINDIR="/extra/kernel/rnpc71/debugBuilder"
MYPWD=$(pwd)

#Reading conf

if [ -f $MYPWD/$CONFF ]
then
	. $MYPWD/$CONFF
else
	echo $"No configuration file found"
	exit 1
fi

MYTEMP="$MYPWD/$KTEMPDIR"

if [ ! -d $MYTEMP ]
then
	mkdir $MYTEMP
fi

#Take backup for each folders

for mykdir in `cat $MYPWD/$KERDIR`
do
	if [ -d "$KERSRC/$mykdir-org" ]
	then
		echo $"$mykdir dir have backuped ..."
		rm -rf $KERSRC/$mykdir-build
		cp -rf $KERSRC/$mykdir  $KERSRC/$mykdir-build
		rm -rf $KERSRC/$mykdir
		mv $KERSRC/$mykdir-org $KERSRC/$mykdir
	else
		echo $"Backup for $mykdir not found ..."
		err=1
	fi
done

exit $err

