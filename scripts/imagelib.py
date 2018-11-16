# ***************************************************************************************
# ***************************************************************************************
#
#		Name : 		imagelib.py
#		Author :	Paul Robson (paul@robsons.org.uk)
#		Date : 		15th November 2018
#		Purpose :	Binary Image Library
#
# ***************************************************************************************
# ***************************************************************************************

class ColorForthImage(object):
	def __init__(self,fileName = "boot.img"):
		self.fileName = fileName
		h = open(fileName,"rb")
		self.image = [x for x in h.read(-1)]
		self.sysInfo = self.read(0,0x8004)+self.read(0,0x8005)*256
		self.pageTable = self.read(0,self.sysInfo+16)+self.read(0,self.sysInfo+17)*256
		self.forthDictionary = {}
		self.macroDictionary = {}
		self.loadDictionary()
		h.close()
	#
	#		Return sys.info address
	#
	def getSysInfo(self):
		return self.sysInfo 

	#
	#		Return dictionary page
	#
	def dictionaryPage(self):
		return 0x20
	#
	#		Return page with code in.
	#
	def currentCodePage(self):
		return self.read(0,self.sysInfo+4)
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
		if page >= 0x20:
			pageTableEntry = self.pageTable + ((page - 0x20) >> 1)
			if self.read(0,pageTableEntry) == 0:
				self.write(0,pageTableEntry,dataType)
	#
	#		Expand physical size of image to include given address
	#
	def expandImage(self,page,address):
		required = self.address(page,address)
		while len(self.image) <= required:
			self.image.append(0x00)
	#
	#		Add entry to image dictionary (if not private) and local copy
	#
	def addDictionary(self,name,page,address,isMacroEntry):
		name = name.strip().lower()
		if name[0] != "_":
			self.addImageDictionary(name,page,address,isMacroEntry)
		addDict = self.macroDictionary if isMacroEntry else self.forthDictionary
		assert name not in addDict,"Duplicate entry "+name
		addDict[name] = [ name,page,address ]
	#
	#		Add a physical entry to the image dictionary
	#
	def addImageDictionary(self,name,page,address,isMacroEntry):
		p = self.findEndDictionary()
		#print("{0:04x} {1:20} {2:02x}:{3:04x}".format(p,name,page,address))
		assert len(name) < 32 and name != "","Bad name '"+name+"'"
		dp = self.dictionaryPage()
		self.lastDictionaryEntry = p
		self.write(dp,p+0,len(name)+5)
		self.write(dp,p+1,page)
		self.write(dp,p+2,address & 0xFF)
		self.write(dp,p+3,address >> 8)
		self.write(dp,p+4,len(name)+0x80 if isMacroEntry else len(name))
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
	#		Remove dictionary private words
	#
	def removeDictionaryPrivateWords(self):
		self.forthDictionary = self.privateRemove(self.forthDictionary)
		self.macroDictionary = self.privateRemove(self.macroDictionary)
	#
	def privateRemove(self,dict):
		keys = [x for x in dict.keys() if x[0] == "_"]
		for k in keys:
			del dict[keys]
	#
	#		Load the dictionary in from the image.
	#
	def loadDictionary(self):
		p = 0xC000
		dPage = self.dictionaryPage()
		while self.read(dPage,p) != 0:
			sByte = self.read(dPage,p+4)
			name = ""
			for i in range(0,sByte & 0x3F):
				name += chr(self.read(dPage,p+5+i))
			target = self.macroDictionary if (sByte & 0x80) !=0 else self.forthDictionary 
			target[name] = [name,self.read(dPage,p+1),self.read(dPage,p+2)+self.read(dPage,p+3)*256]
			#print(p,name,target[name])
			p = p + self.read(dPage,p)
	#
	#		Allocate page of memory to a specific purpose.
	#
	def findFreePage(self):
		p = self.getSysInfo() + 16
		pageUsageTable = self.read(0,p)+self.read(0,p+1)*256
		page = 0x20
		while self.read(0,pageUsageTable) != 0:
			page += 0x2
			pageUsageTable += 1
			assert self.read(0,pageUsageTable) != 255,"No space left in page usage table."
		self.write(0,pageUsageTable,2)
		return page	
	#
	#		Write the image file out.
	#
	def save(self,fileName = None):
		fileName = self.fileName if fileName is None else fileName
		h = open(fileName,"wb")
		h.write(bytes(self.image))		
		h.close()

if __name__ == "__main__":
	z = ColorForthImage()
	print(len(z.image))
	print(z.address(z.dictionaryPage(),0xC000))
	z.save()
	print(z.forthDictionary)
	print(z.macroDictionary)
