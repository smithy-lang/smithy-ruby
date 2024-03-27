# frozen_string_literal: true

require 'fileutils'

WHITELABEL_DIR = 'codegen/smithy-ruby-codegen-test/build/smithyprojections/smithy-ruby-codegen-test/white-label/ruby-codegen/white_label'


namespace :codegen do
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

  task 'clean' do
    Dir.chdir('codegen') do
      sh('./gradlew clean')
    end
  end

  task 'build' => 'verify-java' do
    Dir.chdir('codegen') do
      sh('./gradlew build')
    end
  end

  rule /codegen:build:.+/ => 'codegen:verify-java' do |task|
    project = task.name.split(':').last
    Dir.chdir('codegen') do
      sh("./gradlew #{project}:build")
    end
  end
end

namespace :test do
  task 'white_label' do
    sh("bundle exec rspec #{WHITELABEL_DIR}/spec -I #{WHITELABEL_DIR}/lib -I hearth/lib")
  end

  task 'hearth' do
    sh("bundle exec rspec hearth/spec -I hearth/lib -I hearth/spec --require spec_helper")
  end

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
end

namespace :rbs do

  task 'hearth' do
    sh("bundle exec rbs -I hearth/sig validate")
    # TODO - do we want the same rbs validate + spycheck?
  end

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

# TODO: Add tasks for rubocop
