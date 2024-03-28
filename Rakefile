# frozen_string_literal: true

require 'fileutils'

def build_path(smithy_project, sdk)
  "codegen/#{smithy_project}/build/smithyprojections/#{smithy_project}/#{sdk}/ruby-codegen/#{sdk}"
end

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

  desc 'Run generated and hand written specs on whitelabel sdk.'
  task 'white_label' do
    sdk_dir = build_path('smithy-ruby-codegen-test', 'white_label')
    sh("bundle exec rspec #{sdk_dir}/spec -I #{sdk_dir}/lib -I hearth/lib")
  end

  desc 'Run specs in Hearth'
  task 'hearth' do
    sh("bundle exec rspec hearth/spec -I hearth/lib -I hearth/spec --require spec_helper")
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
    Dir.chdir(build_path('smithy-ruby-codegen-test', 'white_label')) do
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
    sdk_dir = build_path('smithy-ruby-codegen-test', 'white_label')
    # do basic validation first
    sh("bundle exec rbs -I hearth/sig -I #{sdk_dir}/sig validate")

    # run rspec with rbs spy
    env = {
      'RUBYOPT' => '-r bundler/setup -r rbs/test/setup',
      'RBS_TEST_RAISE' => 'true',
      'RBS_TEST_LOGLEVEL' => 'error',
      'RBS_TEST_OPT' => "-I hearth/sig -I #{sdk_dir}/sig",
      'RBS_TEST_TARGET' => "\"WhiteLabel,WhiteLabel::*,Hearth,Hearth::*\"",
    }
    sh(env, "bundle exec rspec #{sdk_dir}/spec -I #{sdk_dir}/lib -I hearth/lib --tag '~rbs_test:skip'")
  end
end

namespace :rubocop do

  desc 'Runs rubocop on Hearth'
  task 'hearth' do
    Dir.chdir('hearth') do
      sh('rubocop -E -S')
    end
  end

  desc 'Runs rubocop on the hand coded ruby files in codegen'
  task 'codegen' do
    Dir.chdir('codegen') do
      sh('rubocop -E -S')
    end
  end
end
