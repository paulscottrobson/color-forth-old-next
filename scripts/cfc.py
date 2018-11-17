# ***************************************************************************************
# ***************************************************************************************
#
#		Name : 		cfc.py
#		Author :	Paul Robson (paul@robsons.org.uk)
#		Date : 		17th November 2018
#		Purpose :	Binary Image Library
#
# ***************************************************************************************
# ***************************************************************************************
# 	Supports:
#
#		:<word> 			Represents <word> in red
#		<word>				A word in green which is compiled (e.g. macro then forth)
#		"<string>"			A string constant, with space replacing underscore
#  		<integer> 			An integer constant with the -ve postfix.
#		<internal macro>	Support if -if then for next -next begin until -until end
#							forth macro
# 		// 					comments
#
# ***************************************************************************************

from imagelib import *
import re,sys
