# frozen_string_literal: true

namespace :rbs do
  desc 'Run rbs validate and execute specs with rbs spy on hearth'
  task 'hearth' do
    sh('bundle exec rbs -I hearth/sig validate')
    env = {
      'RUBYOPT' => '-r bundler/setup -r rbs/test/setup',
      'RBS_TEST_RAISE' => 'true',
      'RBS_TEST_LOGLEVEL' => 'error',
      'RBS_TEST_OPT' => '-I hearth/sig',
      'RBS_TEST_TARGET' => '"Hearth,Hearth::*"'
    }
    sh(env, "bundle exec rspec hearth/spec -I hearth/lib -I hearth/spec --require spec_helper --tag '~rbs_test:skip'")
  end

  desc 'Run rbs validate and execute specs with rbs spy on white_label'
  task 'white_label' do
    sh("bundle exec rbs -I hearth/sig -I #{$white_label_dir}/sig validate")
    env = {
      'RUBYOPT' => '-r bundler/setup -r rbs/test/setup',
      'RBS_TEST_RAISE' => 'true',
      'RBS_TEST_LOGLEVEL' => 'error',
      'RBS_TEST_OPT' => "-I hearth/sig -I #{$white_label_dir}/sig",
      'RBS_TEST_TARGET' => '"WhiteLabel,WhiteLabel::*,Hearth,Hearth::*"'
    }
    sh(env,
       "bundle exec rspec #{$white_label_dir}/spec -I #{$white_label_dir}/lib -I hearth/lib --tag '~rbs_test:skip'")
  end

  desc 'Run rbs validate and execute specs with rbs spy on rails_json'
  task 'rails_json' do
    sh("bundle exec rbs -I hearth/sig -I #{$rails_json_dir}/sig validate")
    env = {
      'RUBYOPT' => '-r bundler/setup -r rbs/test/setup',
      'RBS_TEST_RAISE' => 'true',
      'RBS_TEST_LOGLEVEL' => 'error',
      'RBS_TEST_OPT' => "-I hearth/sig -I #{$rails_json_dir}/sig",
      'RBS_TEST_TARGET' => '"RailsJson,RailsJson::*,Hearth,Hearth::*"'
    }
    sh(env, "bundle exec rspec #{$rails_json_dir}/spec -I #{$rails_json_dir}/lib -I hearth/lib --tag '~rbs_test:skip'")
  end
end
