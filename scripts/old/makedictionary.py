# ***************************************************************************************
# ***************************************************************************************
#
#		Name : 		makedictionary.py
#		Author :	Paul Robson (paul@robsons.org.uk)
#		Date : 		16th November 2018
#		Purpose :	Extract dictionary items from listing and put in image.
#
# ***************************************************************************************
# ***************************************************************************************

import re,imagelib

image = imagelib.ColorForthImage()

src = [x.strip().lower() for x in open("kernel.lst").readlines() if x.find("cforth") >= 0]
src = [x for x in src if x[:13] == "forth__cforth" or x[:13] == "macro__cforth"]

for line in src:
	m = re.match("^(\w+)\_\_cforth_([\_0-9a-f]+)\s+\=\s+\$([0-9a-f]+)",line)
	assert m is not None,line+" bad"
	wType = m.group(1)
	wName = m.group(2)
	wName = "".join([chr(int(x,16)) for x in wName.split("_")])
	address = int(m.group(3),16)
	#print(wName,wType,address)
	image.addDictionary(wName,image.getCodePage(),address,wType == "macro")

image.save()
