# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

Gem::Specification.new do |spec|
  spec.name          = 'white_label'
  spec.version       = File.read(File.expand_path('VERSION', __dir__)).strip
  spec.author        = 'Amazon Web Services'
  spec.summary       = 'White Label Test Service'
  spec.homepage      = 'https://github.com/smithy-lang/smithy-ruby'
  spec.files         = Dir['lib/**/*.rb', 'VERSION']
  spec.license       = 'Apache-2.0'

  spec.required_ruby_version = '>= 3.0'
  spec.add_runtime_dependency 'hearth', '~> 1.0.0.pre3'
end
