#!/bin/bash

NAME="floppy"
FILE="flp"

while getopts 'N:F:' OPTION ; do
  case "$OPTION" in
    N)   NAME=$OPTARG;;
    F)   FILE=$OPTARG;;
  esac
done

### Erstellen Floppy Disk ###
dd bs=512 count=2880 if=/dev/zero of=$NAME.$FILE

### Formatieren Floppy Disk ###
mkfs.msdos $NAME.$FILE
 
### Einbinden der Floppy Disk
sudo mount -o loop $NAME.$FILE /media/floppy1/

printf "\n\nFloppy Disk $NAME.$FILE wurde erstellt.\n"

if [ -d $NAME ] ; then
	(
	 if [ -f $NAME/platformConfig.xml ] ; then
		(
		  sudo cp $NAME/platformConfig.xml /media/floppy1/
		  printf "platformConfig.xml wurde auf die Floppy Disk kopiert!\n"
		  if [ -f $NAME/clusterConfig.xml ] ; then
			(
			 sudo cp $NAME/clusterConfig.xml /media/floppy1/
			 printf "clusterConfig.xml wurde auf die Floppy Disk kopiert!\n"
			)
			fi
		 sudo umount /media/floppy1/
		 printf "Floppy Disk wurde ausgeworfen\n"
		)
	 else
		(
		  printf "platformConfig.xml nicht gefunden :-("
		)
	fi
	)
else
	(
	printf "Ordner $NAME wurde nicht gefunden\n"
	printf "Bitte Files kopieren und dann Floppy mit folgendem Befehl auswerfen:\nsudo umount /media/floppy1/\n\n"
	)
fi

exit
