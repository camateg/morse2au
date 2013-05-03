require './Au.rb'
require './Morse2Au.rb'

	qso_text = 'cq cq de kb3tix'

	beep = Morse2Au.new('/home/matt/kb3tix.au', 0.8)
	
	beep.strToMorse(qso_text)
	
	beep.writeOut
