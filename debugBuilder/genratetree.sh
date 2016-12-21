#!/bin/bash
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
		echo $"This dir is allready backuped"
	else
		echo $"Making Backup for $mykdir"
		cp -rf $KERSRC/$mykdir	$KERSRC/$mykdir-org 
	fi
done

#Appling printk in two stages

for mykdir in `cat $MYPWD/$KERDIR`
do
	if [ -f $KERSRC/$mykdir/derty_patched.lock ]
	then
		echo "Found derty_patched.lock, Skiping patching $mykdir ..."
	else
		echo $"Appling printk patch to $mykdir"
		for mykfile in `ls -1 $KERSRC/$mykdir/*.c`
		do
			rm -rf $MYTEMP/tempfile.inter1 $MYTEMP/tempfile.inter2
			echo $"Appling printk patch to $mykfile"
			echo $"STAGE-1" 
			$KPERL $BINDIR/step1.pl $mykfile > $MYTEMP/tempfile.inter1 
			echo $"STAGE-2-1"
			$KPERL $BINDIR/step2.pl $MYTEMP/tempfile.inter1 > $MYTEMP/tempfile.inter2 
			echo $"STAGE-2-2" 
			$KPERL $BINDIR/step2.pl $MYTEMP/tempfile.inter2 > $mykfile 
		done
		touch $KERSRC/$mykdir/derty_patched.lock
	fi
done

exit 0

