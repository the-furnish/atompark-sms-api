lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'atompark-sms-api/version'

Gem::Specification.new do |spec|
  spec.name          = 'atompark-sms-api'
  spec.version       = AtomparkSmsApi::VERSION
  spec.authors       = ['uno4ki']
  spec.email         = ['i.have@no.mail']
  spec.description   = 'Atompark SMS API'
  spec.summary       = 'Atompark SMS API wrapper. Works only with v3 api'
  spec.homepage      = 'https://github.com/the-furnish/atompark-sms-api'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(/^bin\//) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^spec\//)
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake', '~> 10.3'
  spec.add_development_dependency 'rspec', '~> 3.1'

  spec.add_dependency 'faraday', '~>0.9'
end
