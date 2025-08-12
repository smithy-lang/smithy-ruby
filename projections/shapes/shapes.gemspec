# frozen_string_literal: true

# This is generated code!

Gem::Specification.new do |spec|
  spec.name        = 'shapes'
  spec.version     = File.read(File.expand_path('../VERSION', __FILE__))
  spec.summary     = 'Generated gem using Smithy'
  spec.authors     = ['Smithy Ruby']
  spec.files       = Dir['lib/**/*.rb', base: __dir__]

  spec.add_dependency('smithy-client', '~> 1')

  spec.required_ruby_version = '>= 3.3'
end
