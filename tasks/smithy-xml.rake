# frozen_string_literal: true

require 'rspec/core/rake_task'

namespace 'smithy-xml' do
  RSpec::Core::RakeTask.new do |t|
    t.pattern = 'gems/smithy-xml/spec/**/*_spec.rb'
    t.rspec_opts = '--format documentation'
  end

  desc 'Run RBS validation and spy tests.'
  task 'rbs' => %w[rbs:validate rbs:test]

  desc 'Run RBS validation.'
  task 'rbs:validate' do
    sh('bundle exec rbs -I gems/smithy-xml/sig -I gems/smithy-schema/sig validate')
  end

  desc 'Run RBS spy tests on all unit tests.'
  task 'rbs:test' do
    env = {
      'RUBYOPT' => '-r bundler/setup -r rbs/test/setup',
      'RBS_TEST_RAISE' => 'true',
      'RBS_TEST_LOGLEVEL' => 'error',
      'RBS_TEST_OPT' => '-I gems/smithy-xml/sig -I gems/smithy-schema/sig',
      'RBS_TEST_TARGET' => '"Smithy,Smithy::*,Smithy::Xml,Smithy::Xml::*"',
      'RBS_TEST_DOUBLE_SUITE' => 'rspec'
    }
    sh(env,
       'bundle exec rspec gems/smithy-xml/spec -I gems/smithy-xml/lib ' \
       "--tag '~rbs_test:skip'")
  end
end
