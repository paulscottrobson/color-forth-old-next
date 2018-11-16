#
#		Tidy up
#
rm temp/__words.asm boot.img kernel.lst files/boot.img
#
#		Build the bootloader
#
pushd ../bootloader
sh build.sh
popd
#
#		Build the assembler file with the vocabulary
#
pushd ../vocabulary
sh build.sh
popd
#
#		Assemble the kernel
#
zasm -buw kernel.asm -l kernel.lst -o boot.img
#
#		Insert vocabulary into the image file.
#
python ../scripts/makedictionary.py