# *********************************************************************************
# *********************************************************************************
#
#		File:		buildwords.py
#		Purpose:	Build composite assembly file to generate scaffolding code.
#		Date : 		16th November 2018
#		Author:		paul@robsons.org.uk
#
# *********************************************************************************
# *********************************************************************************

import os,re
#
#		Get list of word files.
#
fileList = []
for root,dirs,files in os.walk("source"):
	for f in [x for x in files if x[-6:] == ".words"]:
		fileList.append(root+os.sep+f)
fileList.sort()
#
#		Now process them
#
hOut = open("__words.asm","w")
hOut.write(";\n; Generated.\n;\n")
for f in fileList:
	unclosedWord = None
	for l in [x.rstrip().replace("\t"," ") for x in open(f).readlines()]:
		#print(l)
		#
		#		Look for @<marker>.<wrapper> <word> or @end
		#
		if l != "" and l[0] == ";" and l.find("@") >= 0 and l.find("@") < 4:
			m = re.match("^\;\s+\@([\w\.]+)\s*([\w\;\+\-\*\/\.\<\=\>\@\!]*)\s*(.*)$",l)
			assert m is not None,l+" syntax ?"
			marker = m.group(1).lower()
			word = m.group(2).lower()
			wrapper = ""
			#
			#		If it's generator.x word.x work out the wrapper.
			#
			if marker != "end":
				marker = marker.split(".")
				assert marker[0] == "generator" or marker[0] == "word",l
				assert marker[1] == "ix" or marker[1] == "hl" or marker[1] == "ret",l
				wrapper = marker[1]
				marker = marker[0]
			#print(marker,word,wrapper)
			#
			#		If it isn't end, create an executable with the wrapper
			#		If it is a generator, mark the area of the data to be copied
			#
			if marker != "end":
				assert unclosedWord is None,"Not closed at "+l
				unclosedWord = "_cforth_"+("_".join(["{0:02x}".format(ord(x)) for x in word]))
				unclosedIsGenerator = (marker == "generator")
				unclosedWrapper = wrapper
				hOut.write("; =========== {0} {1} {2} ===========\n\n".format(word,marker,wrapper))
				hOut.write("forth_"+unclosedWord+":\n")
				if wrapper == "ix" or wrapper == "hl":
					hOut.write("\tpop {0}\n".format(wrapper))				
				if marker == "generator":
					hOut.write("g_"+unclosedWord+":\n")
			#
			#		If it is an end, mark the end if it is a generator, then complete
			# 		the wrapper from the start. Then for generators create a macro word
			# 		which creates he code to copy the word.
			#
			else:
				assert unclosedWord is not None
				if unclosedIsGenerator:
					hOut.write("e_"+unclosedWord+":\n")
				if unclosedWrapper == "ret":
					hOut.write("\tret\n")
				if unclosedWrapper == "ix" or unclosedWrapper == "hl":
					hOut.write("\tjp ({0})\n".format(unclosedWrapper))

				if unclosedIsGenerator:
					hOut.write("\nmacro_"+unclosedWord+":\n")
					hOut.write("\tld b,e_{0}-g_{0}\n".format(unclosedWord))
					hOut.write("\tld hl,g_{0}\n".format(unclosedWord))
					hOut.write("\tjp MacroExpand\n")
				unclosedWord = None
		else:
			hOut.write(l+"\n")
hOut.close()
