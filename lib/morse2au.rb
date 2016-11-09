require 'morse/morse.rb'
require 'au/Au.rb'

# Generate an .au file of Morse code
#
# Initialize:
#   >> MorseAu.initialize("/home/matt/output.au", 0.5)
#
# Arguments:
#   file: (String)
#   rate: (Float)
#
# Convert a string:
#    >> MorseAu.strToMorse("CQ CQ")
#
# Arguments:
#   text: (String)
#
# Write Out:
#    >> Morse2Au.writeOut
#

class Morse2Au
	@@sample_rate = 16000
	@@wave = ''
	@@io
	@@au = Au.new
	@@freq = 500
	@@rel_speed

	#	
	# Arguments:
	#
	#  ofile: (String)
	#  rel_speed: (Float)
	#
	def self.initialize(ofile, rel_speed)
		@@io = File.open(ofile, "w")
		@@rel_speed = rel_speed
	end

	#
	# Arguments:
	# 
	#  duration: (Integer)
	#
	def self.addBeep(duration)
		0.step(duration, 1.0/@@sample_rate) do |t|
			x = Math.sin(t * @@freq) * 50 + 127
			@@wave << x.to_i.chr
		end
	end

	#
	# Arguments:
	#
	# duration: (Integer)
	#
	def self.addSilence(duration)
		0.step(duration, 1.0/@@sample_rate) do |i|
			@@wave << 0
		end
	end

	#
	# Add a .
	#
	def self.addDit
		self.addBeep(@@rel_speed)
		self.addSilence(@@rel_speed)
	end

	#
	# Add a -
	#
	def self.addDah
		self.addBeep(@@rel_speed * 4)
		self.addSilence(@@rel_speed)
	end

	#	
	# Add a letter / short trailing space
	#
	def self.addLSpace
		self.addSilence(@@rel_speed * 3)
	end

	#
	# Add a word / long trailing space
	#
	def self.addWSpace
		self.addSilence(@@rel_speed * 7)
	end

	#
	# Convert a string to morse code
	#
	# Arguments:
	#   text: (String)
	#
	def self.strToMorse(text)
		text.downcase!
		text.split('').each do |c|
			if /^[a-z0-9]$/.match(c)
				$morse_chars[c].each do |c2|
					if c2 == 0
						self.addDit
					elsif c2 == 1
						self.addDah
					end
				end
				self.addLSpace
			else
				self.addWSpace	
			end
		end	
	end

	#
	# Write out using pre-determined file name
	#
	def self.writeOut
		# No idea about next line
		@@au.data = @@wave #@@wave.slice(0..@@wave.length/2)
		@@au.ds = @@wave.bytesize
		@@au.write(@@io)
	end 
end
