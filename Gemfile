# frozen_string_literal: true

source 'https://rubygems.org'

gem 'rake', require: false
gem 'rubocop'

gem 'smithy', path: 'gems/smithy'
gem 'smithy-cbor', path: 'gems/smithy-cbor'
gem 'smithy-client', path: 'gems/smithy-client'
gem 'smithy-json', path: 'gems/smithy-json'
# gem 'smithy-server', path: 'gems/smithy-server'
gem 'smithy-schema', path: 'gems/smithy-schema'

group :development do
  gem 'byebug', platforms: :ruby
end

group :docs do
  gem 'yard'
  gem 'yard-sitemap', '~> 1.0'
end

group :json do
  gem 'json'
  gem 'oj'
end

group :rbs do
  gem 'rbs', platforms: :ruby
  gem 'steep', platforms: :ruby
end

group :test do
  gem 'rspec'
  gem 'simplecov'
  gem 'webmock'
end

group :xml do
  gem 'libxml-ruby'
  gem 'nokogiri'
  gem 'oga'
  gem 'ox'
  gem 'rexml'
end
