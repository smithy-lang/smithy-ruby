# frozen_string_literal: true

require 'fileutils'

WHITELABEL_DIR = 'codegen/smithy-ruby-codegen-test/build/smithyprojections/smithy-ruby-codegen-test/white-label/ruby-codegen/white_label'
RAILSJSON_DIR = 'codegen/smithy-ruby-rails-codegen-test/build/smithyprojections/smithy-ruby-rails-codegen-test/railsjson/ruby-codegen/rails_json'

namespace :codegen do

  desc 'Verify java version is 17 - required for running codegen with gradle'
  task 'verify-java' do
    # java must be set to a compatible version (17)
    # the java command respects the JAVA_HOME env var
    out = `java -XshowSettings:properties -version 2>&1`
    java_version = out.split("\n")
      .map(&:strip).find { |l| l.start_with?('java.specification.version') }
      &.split&.last

    unless java_version == '17'
      raise "Invalid Java language version: '#{java_version || 'unknown'}'. \n"\
      "Ensure you have installed the JDK and set your JAVA_HOME directory correctly.\n"\
      'Or ensure you have setup jenv using `jenv local 17.0` after adding the correct jdk'
    end
  end

  desc 'Clean all codegen projects'
  task 'clean' do
    Dir.chdir('codegen') do
      sh('./gradlew clean')
    end
  end

  desc 'Build all codegen projects'
  task 'build' => 'verify-java' do
    Dir.chdir('codegen') do
      sh('./gradlew build')
    end
  end

  desc 'Run build on a single codegen project'
  rule /codegen:build:.+/ => 'codegen:verify-java' do |task|
    project = task.name.split(':').last
    Dir.chdir('codegen') do
      sh("./gradlew #{project}:build")
    end
  end
end

namespace :test do

  desc 'Run specs in Hearth'
  task 'hearth' do
    sh("bundle exec rspec hearth/spec -I hearth/lib -I hearth/spec --require spec_helper")
  end

  desc 'Run generated and hand written specs on whitelabel sdk.'
  task 'white_label' do
    sh("bundle exec rspec #{WHITELABEL_DIR}/spec -I #{WHITELABEL_DIR}/lib -I hearth/lib")
  end

  desc 'Run generated protocol specs for rails_json.'
  task 'rails_json' do
    sh("bundle exec rspec #{RAILSJSON_DIR}/spec -I #{RAILSJSON_DIR}/lib -I hearth/lib")
  end

  desc 'Run generated tests taken from smithy (endpoint specs)'
  task 'smithy-core-endpoint-tests' do
    build_dir = 'codegen/smithy-ruby-codegen-test/build/smithyprojections/smithy-ruby-codegen-test'

    test_sdk_dirs = Dir.glob("#{build_dir}/*/ruby-codegen/*")
      .select {|d| !d.include?('white_label') && Dir.exist?("#{d}/spec")}

    specs = test_sdk_dirs.map { |d| "#{d}/spec" }.join(' ')
    includes = test_sdk_dirs.map { |d| "-I #{d}/lib" }.join(' ') + " -I hearth/lib"

    sh("bundle exec rspec #{specs} #{includes}")
  end
end

namespace :steep do
  task 'hearth' do
    Dir.chdir('hearth') do
      # TODO: This still requires the Steepfile in Hearth
      # Note: this does not need to be run with bundle exec, will use the current bundle context
      sh('steep check')
    end
  end

  task 'white_label' do
    steepfile = File.absolute_path('Steepfile')
    Dir.chdir(WHITELABEL_DIR) do
      sh("steep check --steepfile #{steepfile}")
    end
  end

  task 'rails_json' do
    steepfile = File.absolute_path('Steepfile')
    Dir.chdir(RAILSJSON_DIR) do
      sh("steep check --steepfile #{steepfile}")
    end
  end
end

namespace :rbs do

  desc 'Run rbs validate on Hearth'
  task 'hearth' do
    sh("bundle exec rbs -I hearth/sig validate")
    # TODO - do we want the same rbs validate + spycheck?
  end

  desc 'Run rbs validate and execute specs with rbs spy'
  task 'white_label' do
    # do basic validation first
    sh("bundle exec rbs -I hearth/sig -I #{WHITELABEL_DIR}/sig validate")

    # run rspec with rbs spy
    env = {
      'RUBYOPT' => '-r bundler/setup -r rbs/test/setup',
      'RBS_TEST_RAISE' => 'true',
      'RBS_TEST_LOGLEVEL' => 'error',
      'RBS_TEST_OPT' => "-I hearth/sig -I #{WHITELABEL_DIR}/sig",
      'RBS_TEST_TARGET' => "\"WhiteLabel,WhiteLabel::*,Hearth,Hearth::*\"",
    }
    sh(env, "bundle exec rspec #{WHITELABEL_DIR}/spec -I #{WHITELABEL_DIR}/lib -I hearth/lib --tag '~rbs_test:skip'")
  end
end

namespace :rubocop do

  desc 'Runs rubocop on Hearth'
  task 'hearth' do
    Dir.chdir('hearth') do
      sh('rubocop -E -S')
    end
  end

  desc 'Runs rubocop on the hand coded ruby files (tests and middleware/plugins/ect) in codegen'
  task 'codegen' do
    Dir.chdir('codegen') do
      sh('rubocop -E -S')
    end
  end
end

namespace 'benchmark' do

  desc 'Runs a performance benchmark on the SDK'
  task 'run' do
    require 'tmpdir'
    require 'memory_profiler' # MemoryProfiler does not work for JRuby
    require 'json'

    require_relative 'benchmark/benchmark'

    # Modify load path to include codegen gems from build directories
    Dir.glob("codegen/*/build/smithyprojections/**/ruby-codegen/*/lib") do |gem_path|
      $LOAD_PATH.unshift(File.expand_path(gem_path))
    end

    report_data = Benchmark.initialize_report_data
    benchmark_data = report_data["benchmark"]

    puts "Benchmarking gem size/requires/client initialization"
    Dir.mktmpdir("ruby-sdk-benchmark") do |tmpdir|
      Benchmark::Gem.descendants.each do |benchmark_gem_klass|
        benchmark_gem = benchmark_gem_klass.new
        puts "\tBenchmarking #{benchmark_gem.gem_name}"
        gem_data = benchmark_data[benchmark_gem.gem_name] ||= {}
        benchmark_gem.benchmark_gem_size(gem_data)
        benchmark_gem.benchmark_require(gem_data)
        benchmark_gem.benchmark_client(gem_data)
      end
    end

    # Benchmarking operations needs to be done after all require/client init tests
    # have been done.  This ensures that no gem requires/cache state is in
    # process memory for those tests
    puts "\nBenchmarking operations"
    Benchmark::Gem.descendants.each do |benchmark_gem_klass|
      benchmark_gem = benchmark_gem_klass.new
      puts "\tBenchmarking #{benchmark_gem.gem_name}"
      benchmark_gem.benchmark_operations(benchmark_data[benchmark_gem.gem_name])
    end

    puts "Benchmarking complete, writing out report to: benchmark_report.json"
    File.write("benchmark_report.json", JSON.pretty_generate(report_data))
  end

  desc 'Upload/archive the benchmark report'
  task 'archive' do
    require 'aws-sdk-s3'
    require 'securerandom'

    puts 'Archiving benchmark report from GH with '\
        "repo: #{ENV['GH_REPO']}, ref: #{ENV['GH_REF']}, event: #{ENV['GH_EVENT']}"
    folder =
      if ENV['GH_EVENT'] == 'pull_request'
        "pr/#{ENV['GH_REF']}"
      else
        'release'
      end
    key = "#{folder}/#{Time.now.strftime('%Y-%m-%d')}/benchmark_#{SecureRandom.uuid}.json"

    puts "Uploading report to: #{key}"
    client = Aws::S3::Client.new
    client.put_object(
      bucket: 'hearth-performance-benchmark-archive',
      key: key,
      body: File.read('benchmark_report.json')
    )
    puts 'Upload complete'
  end

  desc 'Upload benchmarking data to cloudwatch'
  task 'put-metrics' do
    require 'aws-sdk-cloudwatch'
    require_relative 'benchmark/metrics'

    event =
      if ENV['GH_EVENT'] == 'pull_request'
        'pr'
      else
        'release'
      end
    report = JSON.parse(File.read('benchmark_report.json'))
    target = report['ruby_engine'] + "-" + report['ruby_version'].split('.').first(2).join('.')

    # common dimensions
    report_dims = {
      event: event,
      target: target,
      os: report['os'],
      cpu: report['cpu'],
      env: report['execution_env']
    }

    puts 'Uploading benchmarking metrics'
    client = Aws::CloudWatch::Client.new
    benchmark_data = report['benchmark']
    benchmark_data.each do |gem_name, gem_data|
      dims = report_dims.merge(gem: gem_name)
      gem_data.each do |k, v|
        Benchmark::Metrics.put_metric(
          client: client,
          dims: dims,
          timestamp: report['timestamp'] || Time.now,
          metric_name: k,
          value: v)
      end
    end
    puts "Benchmarking metrics uploaded"
  end
end
