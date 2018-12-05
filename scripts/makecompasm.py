# ***************************************************************************************
# ***************************************************************************************
#
#		Name : 		makecompasm.py
#		Author :	Paul Robson (paul@robsons.org.uk)
#		Date : 		3rd December 2018
#		Purpose :	Make composite assembly file for bootstrap
#
# ***************************************************************************************
# ***************************************************************************************

import re,os,sys
#
#		Get all source
#
source = []
for root,dirs,files in os.walk("sources"):
	for f in files:
		for l in open(root+os.sep+f).readlines():
			source.append(l)
#
#		Tidy it up
#
source = [x if x.find("//") < 0 else x[:x.find("//")] for x in source]
source = [x.replace("\t"," ").rstrip() for x in source if x.strip() != ""]
#
#		Split it up into words
#
words = {}
currentWord = None
for w in source:
	#print(w)
	if w[0] == "@":
		m = re.match("^\@(\w+)\[([a-z]*)\]\s*(.*)$",w)
		assert m is not None,w
		wType = m.group(1)
		wrapper = m.group(2)
		name = m.group(3)
		assert name not in words,"Duplicate "+w
		assert wType == "word" or wType == "macro" or wType == "copies",w
		words[name] = { "type":wType,"code":[],"wrapper":wrapper }
		currentWord = name

	else:
		words[currentWord]["code"].append(w)
#
#		Generate code.
#
keys = [x for x in words.keys()]
keys.sort()
hOut = open("_source.asm","w")
for w in keys:
	hOut.write("; =========== {0} {1} ===========\n\n".format(w,words[w]["type"]))
	scrambled = "_".join(["{0:02x}".format(ord(x)) for x in w+"::"+words[w]["type"][0]+"::"+words[w]["wrapper"]])
	hOut.write("start_"+scrambled+":\n")
	hOut.write("\n".join(words[w]["code"])+"\n")
	hOut.write("end_"+scrambled+":\n")
	hOut.write("\n")
hOut.close()
