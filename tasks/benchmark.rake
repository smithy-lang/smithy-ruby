# frozen_string_literal: true

namespace :benchmark do
  desc 'Runs a performance benchmark on the SDK'
  task 'run' do
    require 'tmpdir'
    require 'memory_profiler' # MemoryProfiler does not work for JRuby
    require 'json'

    require_relative 'benchmark/benchmark'

    # Modify load path to include codegen gems from build directories
    Dir.glob('codegen/*/build/smithyprojections/**/ruby-codegen/*/lib') do |gem_path|
      $LOAD_PATH.unshift(File.expand_path(gem_path))
    end

    report_data = Benchmark.initialize_report_data
    benchmark_data = report_data['benchmark']

    puts 'Benchmarking gem size/requires/client initialization'
    Dir.mktmpdir('ruby-sdk-benchmark') do |_tmpdir|
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

    puts 'Benchmarking complete, writing out report to: benchmark_report.json'
    File.write('benchmark_report.json', JSON.pretty_generate(report_data))
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
      key:,
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
    target = "#{report['ruby_engine']}-#{report['ruby_version'].split('.').first(2).join('.')}"

    # common dimensions
    report_dims = {
      event:,
      target:,
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
          client:,
          dims:,
          timestamp: report['timestamp'] || Time.now,
          metric_name: k,
          value: v
        )
      end
    end
    puts 'Benchmarking metrics uploaded'
  end
end
