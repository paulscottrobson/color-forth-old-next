# ***************************************************************************************
# ***************************************************************************************
#
#		Name : 		makedictionary.py
#		Author :	Paul Robson (paul@robsons.org.uk)
#		Date : 		7th December 2018
#		Purpose :	Get labels from import.list and add to dictionary.
#
# ***************************************************************************************
# ***************************************************************************************

import re,imagelib
from labels import *

print("Importing core words into dictionary.")
#
#		Read labels
#
image = imagelib.ColorForthImage()
labels = LabelExtractor("boot.img.vice").getLabels()
count = 0
#
#		Add each pair to the dictionary
#
words = [x for x in labels.keys() if x[:6] == "start_"]
words.sort()
for w in words:
	name = "".join([chr(int(x,16)) for x in w[6:].split("_")])
	#print(name[:-2],name[-1],labels[w])
	image.addDictionary(name[:-2],image.getCodePage(),labels[w],name[-1] == 'm')
	count += 1
image.save()
print("\tImported {0} words.".format(count))
