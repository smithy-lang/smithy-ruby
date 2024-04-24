# frozen_string_literal: true

source 'https://rubygems.org'

gem 'jmespath'
gem 'rexml'
gem 'hearth', path: './hearth'

gem 'rake', require: false

group :test do
  gem 'rspec'
  gem 'simplecov'
  gem 'webmock'
end

group :development do
  gem 'byebug'
  gem 'rbs'
  gem 'rubocop'
  gem 'steep'
end

group :benchmark do
  gem 'memory_profiler'

  # required for uploading archive/metrics
  gem 'aws-sdk-cloudwatch'
  gem 'aws-sdk-s3'
end
