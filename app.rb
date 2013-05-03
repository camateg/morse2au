require './Au.rb'
require './Beep2.rb'

	qso_text = 'cq cq de kb3tix'

	beep = Beep2.new('/home/matt/kb3tix.au', 0.8)
	
	beep.strToMorse(qso_text)
	
	beep.writeOut
