# ***************************************************************************************
# ***************************************************************************************
#
#		Name : 		imagelib.py
#		Author :	Paul Robson (paul@robsons.org.uk)
#		Date : 		7th December 2018
#		Purpose :	Binary Image Library
#
# ***************************************************************************************
# ***************************************************************************************

import sys

class ColorForthImage(object):
	def __init__(self,fileName = "boot.img"):
		self.fileName = fileName
		h = open(fileName,"rb")
		self.image = [x for x in h.read(-1)]
		h.close()
		self.sysInfo = self.read(0,0x8004)+self.read(0,0x8005)*256
		self.currentPage = 	self.read(0,self.sysInfo+2)
		self.currentAddress = self.read(0,self.sysInfo+0)+self.read(0,self.sysInfo+1)*256
	#
	#		Return sys.info address
	#
	def getSysInfo(self):
		return self.sysInfo 
	#
	#		Get paging size for buffers
	#
	def getPageSize(self):
		return 512
	#
	#		Return dictionary page
	#
	def dictionaryPage(self):
		return 0x20
	#
	#		Return source page information
	#
	def sourcePages(self):
		return [0x22,4]
	#
	#		Return current page and address for next free code.
	#
	def getCodePage(self):
		return self.currentPage
	def getCodeAddress(self):
		return self.currentAddress
	#
	#		Convert a page/z80 address to an address in the image
	#
	def address(self,page,address):
		assert address >= 0x8000 and address <= 0xFFFF
		if address < 0xC000:
			return address & 0x3FFF
		else:
			return (page - 0x20) * 0x2000 + 0x4000 + (address & 0x3FFF)
	#
	#		Read byte from image
	#
	def read(self,page,address):
		self.expandImage(page,address)
		return self.image[self.address(page,address)]
	#
	#		Write byte to image
	#
	def write(self,page,address,data,dataType = 2):
		self.expandImage(page,address)
		assert data >= 0 and data < 256
		self.image[self.address(page,address)] = data
		if page >= self.read(0,self.sysInfo+4):
			self.write(0,self.sysInfo+4,page+1)

	#
	#		Expand physical size of image to include given address
	#
	def expandImage(self,page,address):
		required = self.address(page,address)
		while len(self.image) <= required:
			self.image.append(0x00)
	#
	#		Add a physical entry to the image dictionary
	#
	def addDictionary(self,name,page,address,isMacro):
		p = self.findEndDictionary()
		#print("{0:04x} {1:20} {2:02x}:{3:04x}".format(p,name,page,address))
		assert len(name) < 32 and name != "","Bad name '"+name+"'"
		dp = self.dictionaryPage()
		self.lastDictionaryEntry = p
		self.write(dp,p+0,len(name)+5)
		self.write(dp,p+1,page)
		self.write(dp,p+2,address & 0xFF)
		self.write(dp,p+3,address >> 8)
		self.write(dp,p+4,len(name)+0x80 if isMacro else len(name))
		aname = [ord(x) for x in name]
		for i in range(0,len(aname)):
			self.write(dp,p+5+i,aname[i])
		p = p + len(name) + 5
		self.write(dp,p,0)
	#
	#		Find the end of the dictionary
	#
	def findEndDictionary(self):
		p = 0xC000
		while self.read(self.dictionaryPage(),p) != 0:
			p = p + self.read(self.dictionaryPage(),p)
		return p
	#
	#		Write the image file out.
	#
	def save(self,fileName = None):
		self.write(0,self.sysInfo+0,self.currentAddress & 0xFF)
		self.write(0,self.sysInfo+1,self.currentAddress >> 8)
		self.write(0,self.sysInfo+2,self.currentPage)
		self.write(0,self.sysInfo+3,0)

		fileName = self.fileName if fileName is None else fileName
		h = open(fileName,"wb")
		h.write(bytes(self.image))		
		h.close()

if __name__ == "__main__":
	z = SystemImage()
	print(len(z.image))
	print(z.address(z.dictionaryPage(),0xC000))
	print(z.dictionaryPage())
	z.save()

