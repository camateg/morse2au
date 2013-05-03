require './Au.rb'
require './Morse2Au.rb'

	qso_text = 'CQ CQ CQ de KB3TIX'

	beep = Morse2Au.new('/home/matt/kb3tix.au', 0.8)
	
	beep.strToMorse(qso_text)
	
	beep.writeOut
