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
    generated_spec_task('fixtures/endpoints')
  end

  task 'spec:protocols' do
    generated_spec_task('protocol_tests')
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
    generated_spec_task('fixtures/endpoints', rbs_test: true)
  end

  desc 'Run RBS spy tests for all generated protocol test specs.'
  task 'rbs:protocols' do
    generated_spec_task('protocol_tests', rbs_test: true)
  end

  def generated_spec_task(suite, rbs_test: false) # rubocop:disable Metrics
    plans = []
    spec_paths = []
    sig_paths = %w[gems/smithy-client/sig gems/smithy-schema/sig]
    rbs_targets = %w[Smithy Smithy::* Smithy::Client Smithy::Schema Smithy::Client::* Smithy::Schema::*]
    Dir.glob("gems/smithy/spec/#{suite}/*/model.json") do |model_path|
      test_name = model_path.split('/')[-2]
      test_module = test_name.gsub('-', '').camelize
      model = JSON.load_file(model_path)
      plan = SpecHelper.generate_gem(test_module, :client, model: model)
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

  desc 'Convert all fixture smithy models to JSON AST.'
  task 'sync-fixtures' do
    smithy_build_files = Dir.glob('gems/smithy/spec/fixtures/**/smithy-build.json')
    Dir.glob('gems/smithy/spec/fixtures/**/model.smithy') do |model_path|
      config_arguments =
        smithy_build_files
        .select { |file| model_path.include?(File.dirname(file)) }
        .each { |file| FileUtils.touch(file) } # https://github.com/smithy-lang/smithy/issues/2537
        .map { |file| " --config #{file}" }
        .join
      # AST command does not allow transforms when including config files. Instead, use --aut
      # to simplify the model. However, this can create cases where the model and then the
      # implementation is not accurate, so we first validate the model using dependencies
      # from the config file before syncing.
      sh("smithy validate --severity DANGER#{config_arguments} #{model_path}")
      out_path = model_path.sub('.smithy', '.json')
      sh("smithy ast --aut #{model_path} > #{out_path}")
    end
  end

  desc 'Validate that all fixtures JSON models are up to date.'
  task 'validate-fixtures' do
    failures = []
    Dir.glob('gems/smithy/spec/fixtures/**/model.smithy') do |model_path|
      old = JSON.load_file(model_path.sub('.smithy', '.json'))
      new = JSON.parse(`smithy ast --aut #{model_path}`)
      failures << model_path if old != new
    end
    if failures.any?
      puts 'Fixture models out of sync:'
      failures.each { |m| puts "\t#{m}" }
      raise 'Fixture models are out of sync. Run `bundle exec rake smithy:sync-fixtures` to correct.'
    end
  end

  desc 'Build the upstream protocol tests and copy the source JSON to the test folder'
  task 'sync-protocol-tests' do
    protocol_tests_dir = 'gems/smithy/spec/protocol_tests'
    smithy_build_file = "#{protocol_tests_dir}/smithy-build.json"
    skip_tests_file = File.join(Gem::Specification.find_by_name('smithy').full_gem_path, 'model/skip_tests.smithy')
    FileUtils.touch(smithy_build_file) # https://github.com/smithy-lang/smithy/issues/2537
    sh("smithy build --config #{protocol_tests_dir}/smithy-build.json #{skip_tests_file}")

    # Ideally should have a manifest, but use the smithy-build as the source of truth.
    build_file = JSON.load_file(smithy_build_file)
    build_file['projections'].each_key do |projection_name|
      FileUtils.mkdir_p("#{protocol_tests_dir}/#{projection_name}")
      puts "Syncing protocol tests for #{projection_name}..."
      FileUtils.cp(
        "build/smithy/#{projection_name}/model/model.json",
        "#{protocol_tests_dir}/#{projection_name}/model.json"
      )
    end
  end
end
