require 'bindata'

class Au < BinData::Record
	endian :big
	
	int32	:magic, :value=>0x2e736e64
	int32	:dord,	:value=>24
	int32	:ds
	int32	:enc,	:value=>5
	int32	:sr,	:value=>16000
	int32	:chan,	:value=>1
	string	:data
end
		
