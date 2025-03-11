# frozen_string_literal: true

require 'rspec/core/rake_task'

namespace 'smithy-client' do
  RSpec::Core::RakeTask.new do |t|
    t.pattern = 'gems/smithy-client/spec/**/*_spec.rb'
    t.rspec_opts = '--format documentation'
    t.rspec_opts += ' --tag ~slow:true' unless ENV['CI']
  end

  desc 'Run RBS validation and spy tests.'
  task 'rbs' => %w[rbs:validate rbs:test]

  desc 'Run RBS validation.'
  task 'rbs:validate' do
    sh('bundle exec rbs -I gems/smithy-client/sig -I gems/smithy-schema/sig validate')
  end

  desc 'Run RBS spy tests on all unit tests.'
  task 'rbs:test' do
    env = {
      'RUBYOPT' => '-r bundler/setup -r rbs/test/setup',
      'RBS_TEST_RAISE' => 'true',
      'RBS_TEST_LOGLEVEL' => 'error',
      'RBS_TEST_OPT' => '-I gems/smithy-client/sig -I gems/smithy-schema/sig',
      'RBS_TEST_TARGET' => '"Smithy,Smithy::*,Smithy::Client,Smithy::Client::*"',
      'RBS_TEST_DOUBLE_SUITE' => 'rspec'
    }
    sh(env,
       'bundle exec rspec gems/smithy-client/spec -I gems/smithy-client/lib ' \
       "--tag '~rbs_test:skip'")
  end
end
