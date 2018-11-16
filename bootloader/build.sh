#
#		Delete old files
#
rm /Q bootloader.sna ../files/bootloader.sna
#
#		Assemble bootloader
#
zasm -buw bootloader.asm -o bootloader.sna
#
#		Copy to file area if exists
#
if [ -e bootloader.sna ]
then
	cp bootloader.sna ../files
fi

