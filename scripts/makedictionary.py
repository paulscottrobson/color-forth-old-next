# ***************************************************************************************
# ***************************************************************************************
#
#		Name : 		makedictionary.py
#		Author :	Paul Robson (paul@robsons.org.uk)
#		Date : 		3rd December 2018
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
#		Read label/word pairs in
#
words = [x.replace("\t"," ").strip().lower() for x in open("import.list").readlines() if x.strip() != ""]
words = [x for x in words if x[:2] != "//"]
#
#		Add each pair to the dictionary
#
for w in words:
	m = re.match("^([A-Za-z0-9\_]+)\s+([0-9a-zA-Z\,]+)\s+([a-zA-Z]+)\s*$",w)
	assert m is not None,w+" syntax ?"
	assert m.group(1) in labels,w+ "label ?"
	assert m.group(3) == "forth" or m.group(3) == "label",w+" dest ?"
	image.addDictionary(m.group(2),image.getCodePage(),labels[m.group(1)],m.group(3) == "macro")
	count += 1
image.save()
print("\tImported {0} words.".format(count))
