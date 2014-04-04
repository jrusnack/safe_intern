Gem::Specification.new do |gem|
  gem.name        = 'safe_intern'
  gem.version     = '1.0.1'
  gem.date        = '2014-03-25'
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
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rake-compiler'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'rubocop'
end
