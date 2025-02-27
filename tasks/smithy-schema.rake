# frozen_string_literal: true

require 'rspec/core/rake_task'

namespace 'smithy-schema' do
  RSpec::Core::RakeTask.new do |t|
    t.pattern = 'gems/smithy-schema/spec/**/*_spec.rb'
    t.rspec_opts = '--format documentation'
  end

  desc 'Run RBS validation and spy tests.'
  task 'rbs' => %w[rbs:validate rbs:test]

  desc 'Run RBS validation.'
  task 'rbs:validate' do
    sh('bundle exec rbs -I gems/smithy-schema/sig validate')
  end

  desc 'Run RBS spy tests on all unit tests.'
  task 'rbs:test' do
    env = {
      'RUBYOPT' => '-r bundler/setup -r rbs/test/setup',
      'RBS_TEST_RAISE' => 'true',
      'RBS_TEST_LOGLEVEL' => 'error',
      'RBS_TEST_OPT' => '-I gems/smithy-client/sig',
      'RBS_TEST_TARGET' => '"Smithy::Schema,Smithy::Schema::*"',
      'RBS_TEST_DOUBLE_SUITE' => 'rspec'
    }
    sh(env,
       'bundle exec rspec gems/smithy-schema/spec -I gems/smithy-schema/lib ' \
       "--tag '~rbs_test:skip'")
  end
end
