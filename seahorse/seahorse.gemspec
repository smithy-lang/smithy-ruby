# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = 'seahorse'
  spec.version       = File.read(File.expand_path('VERSION', __dir__)).strip
  spec.summary       = 'A base library for Smithy generated SDKs'
  spec.authors       = ['Amazon Web Services']
  spec.require_paths = ['lib']
  spec.files         = Dir['lib/**/*.rb']
end
