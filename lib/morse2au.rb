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
	@tmpPath

	def self.initialize(ofile, rel_speed)
		@@io = File.open(ofile, "w")
		@@rel_speed = rel_speed
	end

	def self.getTmp
		@tmpPath
	end

	def self.addBeep(duration)
		0.step(duration, 1.0/@@sample_rate) do |t|
			x = Math.sin(t * @@freq) * 50 + 127
			@@wave << x.to_i.chr
		end
	end

	def self.addSilence(duration)
		0.step(duration, 1.0/@@sample_rate) do |i|
			@@wave << 0
		end
	end

	def self.addDit
		self.addBeep(@@rel_speed)
		self.addSilence(@@rel_speed)
	end

	def self.addDah
		self.addBeep(@@rel_speed * 4)
		self.addSilence(@@rel_speed)
	end

	def self.addLSpace
		self.addSilence(@@rel_speed * 3)
	end

	def self.addWSpace
		self.addSilence(@@rel_speed * 7)
	end

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

	def self.writeOut
		# No idea about next line
		@@au.data = @@wave #@@wave.slice(0..@@wave.length/2)
		@@au.ds = @@wave.bytesize
		@@au.write(@@io)
	end 
end
