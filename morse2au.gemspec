Gem::Specification.new do |s|
	s.name = 'morse2au'
	s.version = '0.1.3'
	s.date = '2016-11-08'
	s.summary = 'Morse2Au'
	s.description = 'Generate a morse code .au file from a string'
	s.authors = ['Matthew Fleeger']
	s.email = 'mfleeger5@gmail.com'
	s.files = ['lib/morse2au.rb', 'lib/morse/morse.rb', 'lib/au/Au.rb']
	s.add_runtime_dependency 'bindata'
	s.homepage = 'http://rubygems.org/gems/morse2au'
	s.license = 'BSD'
end
