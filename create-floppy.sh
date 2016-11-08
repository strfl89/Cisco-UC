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

printf "\n\nFloppy Disk $NAME.$FILE wurde erstellt.\nBitte Files kopieren und dann Floppy mit folgendem Befehl auswerfen:\nsudo umount /media/floppy1/\n\n"

exit
 

