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

def encrypt(name):
	return "cforth_"+"_".join(["{0:02x}".format(ord(x)) for x in name])		
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
currentWord = None
hOut = open("__words.asm","w")
hOut.write(";\n; Generated.\n;\n")
for f in fileList:
	unclosedWord = None
	for l in [x.rstrip().replace("\t"," ") for x in open(f).readlines()]:
		#
		#		Look for @<marker>.<wrapper> <word> or @end
		#
		if l != "" and l[0] == ";" and l.find("@") >= 0 and l.find("@") < 4:
			hOut.write("\n"+l+"\n\n")
			sl = l.strip().lower()
			#
			#		If it's @forth or @macro
			#
			if sl.find("@end") < 0:
				assert currentWord is None
				#
				#	Workout the word, wrapper and forth/macro target
				#
				m = re.match("^\;\s+\@(\w+)\[(\w+)\]\s+(.*)$",sl)
				assert m is not None,sl + "????"
				currentWord = m.group(3)
				currentWrapper = m.group(2)
				currentDirectory = m.group(1)
				encryptName = encrypt(currentWord)
				assert currentWrapper == "ix" or currentWrapper == "hl" or currentWrapper == "ret"
				#
				#	Start of executable word
				#
				hOut.write("{0}_forth:\n".format(encryptName))
				#
				#	Stack adjustment encryption
				#
				if currentWrapper == "ix" or currentWrapper == "hl":
					hOut.write("    pop {0}\n".format(currentWrapper))
				#
				#	Start of actual code.
				#
				hOut.write("{0}_code:\n".format(encryptName))
			#
			#		@end
			#
			else:
				assert currentWord is not None
				#
				#	End of actual code
				#
				hOut.write("{0}_end:\n".format(encryptName))
				#
				#	Exiting code
				#
				if currentWrapper == "ix" or currentWrapper == "hl":
					hOut.write("    jp ({0})\n".format(currentWrapper))
				else:
					hOut.write("    ret\n")
				#
				#	Macro version.
				#
				if currentDirectory == "macro":
					hOut.write("{0}_macro:\n".format(encryptName))
					hOut.write("    ld b,{0}_end-{0}_start\n".format(encryptName))
					hOut.write("    ld hl,{0}_start\n".format(encryptName))
					hOut.write("    jp MacroExpand\n")
				currentWord = None
		else:
			hOut.write(l+"\n")
hOut.close()
