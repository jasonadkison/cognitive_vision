# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cognitive_vision/version'

Gem::Specification.new do |spec|
  spec.name          = 'cognitive_vision'
  spec.version       = CognitiveVision::VERSION
  spec.authors       = ['Carlos Ribeiro']
  spec.email         = ['mail@carlosribeiro.me']

  spec.summary       = 'Client to integrate with Microsoft Cognitive - Computer Vision API'
  spec.description   = 'Client to integrate with Microsoft Cognitive - Computer Vision API'
  spec.homepage      = 'https://github.com/mattr/cognitive_vision'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.' unless spec.respond_to?(:metadata)
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'codeclimate-test-reporter'
  spec.add_development_dependency 'dotenv', '~> 2.1.1'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'pry-nav'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'webmock', '~> 2.1.0'
  spec.add_development_dependency 'vcr', '~> 3.0.3'
end
