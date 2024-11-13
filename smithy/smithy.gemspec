# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = 'smithy'
  spec.version       = File.read(File.expand_path('VERSION', __dir__)).strip
  spec.summary       = 'Generic/Extensible Smithy Ruby SDK code generation.'
  spec.authors       = ['Amazon Web Services']
  spec.homepage      = 'https://github.com/smithy-lang/smithy-ruby'
  spec.require_paths = ['lib']
  spec.files         = Dir['CHANGELOG.md', 'VERSION', 'bin/**',
                           'lib/**/*.rb', 'sig/lib/**/*.rbs']

  spec.required_ruby_version = '>= 3.0'

  spec.license = 'Apache-2.0'
end
