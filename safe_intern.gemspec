Gem::Specification.new do |gem|
  gem.name        = 'safe_intern'
  gem.version     = '1.1.0'
  gem.date        = Date.today.to_s
  gem.summary     = 'Safe String#intern'
  gem.description = 'Safe implementation of String#intern'
  gem.authors     = ["Jan Rusnacko"]
  gem.email       = 'rusnackoj@gmail.com'
  gem.files       = `git ls-files`.split($/)
  gem.extensions  = 'ext/symbol_defined/extconf.rb'
  gem.required_ruby_version = ['>= 1.9.3']
  gem.homepage    = 'https://github.com/jrusnack/safe_intern'
  gem.license     = 'MIT'
  gem.cert_chain  = ['certs/gem-jrusnack.pem']
  gem.add_development_dependency 'rake', '>= 10.0.0'
  gem.add_development_dependency 'rake-compiler', '>= 0.9'
  gem.add_development_dependency 'rspec', '>= 2.14'
  gem.add_development_dependency 'rubocop', '>= 0'
end
