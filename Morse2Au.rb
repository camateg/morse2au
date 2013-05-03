require './morse.rb'

class Morse2Au
	@@sample_rate = 16000
	@@wave = ''
	@@io
	@@au = Au.new
	@@freq = 800
	@@rel_speed
	@tmpPath

	def initialize(ofile, rel_speed)
		@@io = File.open(ofile, "w")
		@@rel_speed = rel_speed
	end

	def getTmp
		@tmpPath
	end

	def addBeep(duration)
		0.step(duration, 1.0/@@sample_rate) do |t|
			x = Math.sin(t * @@freq) * 50 + 127
			@@wave << x.to_i.chr
		end
	end

	def addSilence(duration)
		0.step(duration, 1.0/@@sample_rate) do |i|
			@@wave << 0
		end
	end

	def addDit
		self.addBeep(@@rel_speed)
		self.addSilence(@@rel_speed)
	end

	def addDah
		self.addBeep(@@rel_speed * 4)
		self.addSilence(@@rel_speed)
	end

	def addLSpace
		self.addSilence(@@rel_speed * 3)
	end

	def addWSpace
		self.addSilence(@@rel_speed * 7)
	end

	def strToMorse(text)
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

	def writeOut
		@@au.data = @@wave
		@@au.write(@@io)
	end 
end
