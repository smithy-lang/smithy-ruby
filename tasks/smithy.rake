# frozen_string_literal: true

require 'rspec/core/rake_task'

require_relative '../gems/smithy/spec/spec_helper'

namespace :smithy do
  task 'spec' => %w[spec:unit spec:endpoints spec:protocols]

  RSpec::Core::RakeTask.new('spec:unit') do |t|
    t.pattern = 'gems/smithy/spec/**/*_spec.rb'
    t.rspec_opts = '--format documentation'
    t.rspec_opts += ' --tag rbs_test' if ENV['SMITHY_RUBY_RBS_TEST']
  end

  task 'spec:endpoints' do
    generated_spec_task('endpoints')
  end

  task 'spec:protocols' do
    generated_spec_task('protocols')
  end

  desc 'Run RBS spy tests for unit tests and generated specs.'
  task 'rbs' => %w[rbs:unit rbs:endpoints rbs:protocols]

  desc 'Run RBS spy tests for all unit tests that use fixtures.'
  task 'rbs:unit' do
    env = { 'SMITHY_RUBY_RBS_TEST' => 'true' }
    sh(env, 'bundle exec rake smithy:spec:unit')
  end

  desc 'Run RBS spy tests for all generated endpoint provider specs.'
  task 'rbs:endpoints' do
    generated_spec_task('endpoints', rbs_test: true)
  end

  desc 'Run RBS spy tests for all generated protocol test specs.'
  task 'rbs:protocols' do
    generated_spec_task('protocols', rbs_test: true)
  end

  def generated_spec_task(suite, rbs_test: false) # rubocop:disable Metrics
    plans = []
    spec_paths = []
    sig_paths = %w[gems/smithy-client/sig gems/smithy-schema/sig]
    rbs_targets = %w[Smithy Smithy::* Smithy::Client Smithy::Schema Smithy::Client::* Smithy::Schema::*]
    Dir.glob("gems/smithy/spec/fixtures/#{suite}/*/model.json") do |model_path|
      test_name = model_path.split('/')[-2]
      test_module = test_name.gsub('-', '').camelize
      plan = SpecHelper.generate_gem(test_module, :client, fixture: "#{suite}/#{test_name}")
      plans << plan
      spec_paths << "#{plan.destination_root}/spec"
      sig_paths << "#{plan.destination_root}/sig"
      rbs_targets += [test_module, "#{test_module}::*"]
    end
    env =
      if rbs_test
        {
          'RUBYOPT' => '-r bundler/setup -r rbs/test/setup',
          'RBS_TEST_RAISE' => 'true',
          'RBS_TEST_LOGLEVEL' => 'error',
          'RBS_TEST_OPT' => sig_paths.map { |p| "-I #{p}" }.join(' '),
          'RBS_TEST_TARGET' => "\"#{rbs_targets.join(',')}\"",
          'RBS_TEST_DOUBLE_SUITE' => 'rspec'
        }
      else
        {}
      end
    sh(env, "bundle exec rspec #{spec_paths.join(' ')}")
  ensure
    plans.each { |plan| SpecHelper.cleanup_gem(plan) }
  end

  desc 'Convert all fixture smithy models to JSON AST representation.'
  task 'sync-fixtures' do
    Dir.glob('gems/smithy/spec/fixtures/**/model.smithy') do |model_path|
      config_arguments = config_arguments(model_path)
      out_path = model_path.sub('.smithy', '.json')
      sh("smithy ast#{config_arguments} #{model_path} > #{out_path}")
    end
  end

  desc 'Validate that all fixtures JSON models are up to date.'
  task 'validate-fixtures' do
    failures = []
    Dir.glob('gems/smithy/spec/fixtures/**/model.smithy') do |model_path|
      config_arguments = config_arguments(model_path)
      old = JSON.load_file(model_path.sub('.smithy', '.json'))
      new = JSON.parse(`smithy ast #{config_arguments} #{model_path}`)
      failures << model_path if old != new
    end
    if failures.any?
      puts 'Fixture models out of sync:'
      failures.each { |m| puts "\t#{m}" }
      raise 'Fixture models are out of sync. Run `bundle exec rake smithy:sync-fixtures` to correct.'
    end
  end

  def config_arguments(model_path)
    Dir.glob('gems/smithy/spec/fixtures/**/smithy-build.json')
       .select { |file| model_path.include?(File.dirname(file)) }
       .each { |file| FileUtils.touch(file) } # https://github.com/smithy-lang/smithy/issues/2537
       .map { |file| " --config #{file}" }
       .join
  end
end
