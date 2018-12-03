# ***************************************************************************************
# ***************************************************************************************
#
#		Name : 		makebootstrap.py
#		Author :	Paul Robson (paul@robsons.org.uk)
#		Date : 		3rd December 2018
#		Purpose :	Make bootstrap file
#
# ***************************************************************************************
# ***************************************************************************************

import labels,re,sys
#
#		Get all relevant labels
#
labels = labels.LabelExtractor("code.bin.vice").getLabels()
words = [x for x in labels.keys() if x[:6] == "start_"]
words.sort()
binary = [x for x in open("code.bin","rb").read(-1)]
#
#		Process each one.
#
hOut = open("bootstrap.cf","w")
hOut = sys.stdout
hOut.write("//\n//    Generated.\n//\n")
for word in words:
	name = "".join([chr(int(x,16)) for x in word[6:].split("_")])
	parts= name.split("::")
	codeBegin = labels[word]
	codeEnd = labels[word.replace("start","end")]
	code = binary[codeBegin:codeEnd]
	wrappedCode = [x for x in code]
	# TODO : Wrap binary.
	if parts[1] == "w":
		codeGen = " ".join(["[{0}] [c,]".format(n) for n in wrappedCode])
		hOut.write("[forth] :{0} {1}\n".format(parts[0],codeGen))
	if parts[1] == "m" or parts[1] == "c":
		codeGen = " ".join(["{0} c,".format(x) for x in code])
		hOut.write("[macro] :{0} {1} [201] [c,]\n".format(parts[0],codeGen))
	if parts[1] == "c":
		hOut.write("[forth] :{0} {0} [201] [c,]\n".format(parts[0]))
	#print(name,wType,codeBegin,codeEnd,code)
	#print(genCode)
	hOut.write("\n")
hOut.close()
