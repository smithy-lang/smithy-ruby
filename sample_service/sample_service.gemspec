Gem::Specification.new do |spec|
  spec.name          = 'sample_service'
  spec.version       = '0.0.1'
  spec.author        = 'Amazon Web Services'
  spec.summary       = 'Sample Service'
  spec.files         = Dir['lib/**/*.rb']

  spec.add_runtime_dependency 'seahorse', '~> 1'
end
