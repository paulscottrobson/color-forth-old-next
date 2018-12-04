# ***************************************************************************************
# ***************************************************************************************
#
#		Name : 		cfc.py
#		Author :	Paul Robson (paul@robsons.org.uk)
#		Date : 		4th December 2018
#		Purpose :	Colour Forth Compiler
#
# ***************************************************************************************
# ***************************************************************************************

from imagelib import *
import sys,os,re

class CompilerException(Exception):
	pass

# ***************************************************************************************
#
#									Compiler class
#
# ***************************************************************************************

class ColorForthCompiler(object):
	#
	#		Initialise
	#
	def __init__(self,fileName = "boot.img"):
		self.image = ColorForthImage(fileName)
		self.dictionary = self.image.getDictionary()
		self.topOfStack = 0 							
		print(self.dictionary)
	#
	#		Compile a specific word.
	#
	def compileWord(self,word):
		#
		#		Executable
		#
		if word[0] == "[" and word[-1] == "]" and len(word) > 2:
			word = word[1:-1]
			if re.match("^\d+$",word) is not None:
				self.topOfStack = int(word)
				print(self.topOfStack)
				return
			if word == "c,":
				self.image.cByte(self.topOfStack)
				return
			raise CompilerException("Cannot execute "+word)
		#
		#		Compilable
		#
		if re.match("^\d+$",word) is not None:
			self.image.cByte(0xD5)						# push de
			self.image.cByte(0x11)						# ld de,xxxx
			self.image.cWord(int(word) & 0xFFFF)
			return
		if word in self.dictionary:
			self.image.cByte(0xCD)						# call xxxx
			self.image.cWord(self.dictionary[word]["address"])
			
		raise CompilerException("Cannot understand "+word)

cm = ColorForthCompiler()

cm.compileWord("[235]")
cm.compileWord("[c,]")
cm.compileWord("266")
cm.compileWord(",")
cm.compileWord("c,")