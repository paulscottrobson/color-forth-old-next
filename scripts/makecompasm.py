# ***************************************************************************************
# ***************************************************************************************
#
#		Name : 		makecompasm.py
#		Author :	Paul Robson (paul@robsons.org.uk)
#		Date : 		7th December 2018
#		Purpose :	Make composite assembly file for assembler
#
# ***************************************************************************************
# ***************************************************************************************

import re,os,sys
print("Building vocabulary assembler file.")
#
#		Get all source
#
source = []
for root,dirs,files in os.walk("sources"):
	for f in files:
		if f[-7:] == ".source":
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
	if w[0] == "@":
		parts = w.split(" ")
		assert parts[-1] not in words,"Duplicate "+w
		assert parts[0] == "@word.hl" or parts[0] == "@word.ix" or parts[0] == "@word.ret" or parts[0] == "@macro" or parts[0] == "@both",w
		currentWord = parts[-1]
		words[currentWord] = { "type":parts[0][1:],"code":[] }

	else:
		words[currentWord]["code"].append(w)
#
#		Generate code.
#
keys = [x for x in words.keys()]
keys.sort()
count = 0
hOut = open("__words.asm","w")
for w in keys:
	hOut.write("; =========== {0} {1} ===========\n\n".format(w,words[w]["type"]))
	scrambledForth = "_".join(["{0:02x}".format(ord(x)) for x in w+".f"])
	scrambledMacro = "_".join(["{0:02x}".format(ord(x)) for x in w+".m"])
	isMacro = words[w]["type"] == "macro" or words[w]["type"] == "both"

	if len(words[w]["code"]) == 0:
		print("\tWarning ! '{0}' has no code.".format(w))
	if isMacro:
		count += 1
		hOut.write("start_"+scrambledMacro+":\n")
		hOut.write(" ld a,end_{0}-start_{0}-5\n".format(scrambledMacro))
		hOut.write(" call COMUCopyCode\n")
		hOut.write("\n".join(words[w]["code"])+"\n")
		hOut.write("end_"+scrambledMacro+":\n\n")

	if words[w]["type"] == "both" or words[w]["type"][:4] == "word":
		count += 1
		wrapper = "ix" if words[w]["type"] == "both" else words[w]["type"][5:]
		hOut.write("start_"+scrambledForth+":\n")
		if wrapper != "ret":
			hOut.write(" pop {0}\n".format(wrapper))

		hOut.write("\n".join(words[w]["code"])+"\n")

		if wrapper != "ret":
			hOut.write(" jp ({0})\n\n".format(wrapper))
		else:
			hOut.write(" ret\n")


hOut.close()
print("\tBuilt assembly file with {0} words.".format(count))