# ***************************************************************************************
# ***************************************************************************************
#
#		Name : 		showinfo.py
#		Author :	Paul Robson (paul@robsons.org.uk)
#		Date : 		15th November 2018
#		Purpose :	Show image information
#
# ***************************************************************************************
# ***************************************************************************************

import re
from imagelib import *


image = ColorForthImage()
sysinfo = image.getSysInfo()
print("Dictionary Page           ${0:02x}".format(image.dictionaryPage()))
p = image.read(0,sysinfo+4)
a = image.read(0,sysinfo+0)+image.read(0,sysinfo+1)*256
print("Free Code is at           ${0:02x} ${1:04x}".format(p,a))
p = image.read(0,sysinfo+12)
a = image.read(0,sysinfo+8)+image.read(0,sysinfo+9)*256
print("Image boots to            ${0:02x} ${1:04x}".format(p,a))
a = image.read(0,sysinfo+20)+image.read(0,sysinfo+21)*256
print("Z80 stack is at           ${0:04x}".format(a))

pageUsageTable = image.read(0,sysinfo+16)+image.read(0,sysinfo+17)*256
pageCurrent = 0x20
pageUsage = { 0:[], 1:[] , 2:[], 3:[] }
while image.read(0,pageUsageTable) != 0xFF:
	usage = image.read(0,pageUsageTable)
	if usage not in pageUsage:
		pageUsage[usage] = []
	else:
		pageUsage[usage].append(pageCurrent)
	pageUsageTable += 1
	pageCurrent += 2

print("Pages are from            ${0:02x} to ${1:02x}".format(0x20,pageCurrent-2))
print("\tSystem            {0}".format(" ".join([str("${0:02x}".format(x)) for x in pageUsage[1]])))
print("\tUser Code         {0}".format(" ".join([str("${0:02x}".format(x)) for x in pageUsage[2]])))
print("\tUser Data         {0}".format(" ".join([str("${0:02x}".format(x)) for x in pageUsage[3]])))