require File.expand_path('../version.rb', __FILE__)
require File.expand_path('../files.rb', __FILE__)

Gem::Specification.new do |s|
  s.specification_version     = 1 if s.respond_to? :specification_version=
  s.required_rubygems_version = Gem::Requirement.new('>= 0') if s.respond_to? :required_rubygems_version
  s.required_ruby_version     = '>= 1.9.3'

  s.name                      = 'reactive_extensions'
  s.version                   = ReactiveExtensions.gem_version
  s.date                      = '2014-11-30'

  s.description               = 'Handy extensions to core Ruby classes'
  s.summary                   = 'ReactiveExtensions, a spinoff of ReactiveSupport, adds a variety of useful methods to core Ruby classes.'

  s.authors                   = ['Dana Scheider']
  s.email                     = 'dana.scheider@gmail.com'

  s.files                     = ReactiveExtensions.files
  s.require_paths             = ['lib']
  s.test_files                = s.files.select {|path| path =~ /^spec\/.*\.rb/ }
  s.licenses                  = 'MIT'
  s.extra_rdoc_files          = %w(README.md LICENSE)

  s.add_runtime_dependency     'reactive_support', '>= 0.5.0.beta'

  s.add_development_dependency 'rspec', '~> 3.1'
  s.add_development_dependency 'bundler', '~> 1.7'
  s.add_development_dependency 'coveralls', '~> 0.7', '>= 0.7.2'
  s.add_development_dependency 'simplecov', '~> 0.9', '>= 0.9.1'
  s.add_development_dependency 'rake', '~> 10.4'

  s.has_rdoc         = true
  s.homepage         = 'http://github.com/danascheider/reactive_extensions'
  s.rdoc_options     = %w(--line-numbers --inline-source --title ReactiveExtensions)
  s.rubygems_version = '1.1.1'
end