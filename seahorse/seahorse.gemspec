# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = 'seahorse'
  spec.version       = File.read(File.expand_path('VERSION', __dir__)).strip
  spec.summary       = 'A base library for Smithy generated SDKs'
  spec.authors       = ['Amazon Web Services']
  spec.require_paths = ['lib']
  spec.files         = Dir['CHANGELOG.md', 'VERSION',
                           'lib/**/*.rb', 'sig/lib/**/*.rbs']

  spec.required_ruby_version = '>= 2.5'

  spec.add_runtime_dependency 'jmespath', '~> 1.4'
  spec.add_runtime_dependency 'rexml'

  spec.metadata = { 'rubygems_mfa_required' => 'true' }
  spec.license = 'Apache-2.0'
end
