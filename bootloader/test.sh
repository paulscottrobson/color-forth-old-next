#
#		Create the bootloader
#
sh build.sh
#
#		Create a dummy boot.img file, just a break
#
rm boot.img
python makedemoimage.py
#
#		Try to load and run it
#
if [ -e  bootloader.sna ]
then
wine ../bin/CSpect.exe -zxnext -cur -brk -exit -w3 bootloader.sna 2>/dev/null
fi
