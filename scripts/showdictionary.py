# ***************************************************************************************
# ***************************************************************************************
#
#		Name : 		showdictionary.py
#		Author :	Paul Robson (paul@robsons.org.uk)
#		Date : 		3rd December 2018
#		Purpose :	List Dictionary contents
#
# ***************************************************************************************
# ***************************************************************************************

import re
from imagelib import *

image = ColorForthImage()
cdict = image.getDictionary()
keys = [x for x in cdict.keys()]
keys.sort(key = lambda x:cdict[x]["dictaddr"])
for k in keys:
	e = cdict[k]
	print("[{0:04x}] {1:02x}:{2:04x} {4}: {3}".format(e["dictaddr"],e["page"],e["address"],e["name"],e["subset"]))

	