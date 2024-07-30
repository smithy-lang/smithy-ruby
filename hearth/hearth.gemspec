# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = 'hearth'
  spec.version       = File.read(File.expand_path('VERSION', __dir__)).strip
  spec.summary       = 'A base library for Smithy generated SDKs'
  spec.authors       = ['Amazon Web Services']
  spec.homepage      = 'https://github.com/smithy-lang/smithy-ruby'
  spec.require_paths = ['lib']
  spec.files         = Dir['CHANGELOG.md', 'VERSION',
                           'lib/**/*.rb', 'sig/lib/**/*.rbs']

  spec.required_ruby_version = '>= 3.0'

  spec.add_dependency 'http-2'
  spec.add_dependency 'jmespath'
  spec.add_dependency 'rexml'

  spec.license = 'Apache-2.0'
end
