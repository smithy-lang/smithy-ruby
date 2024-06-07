# frozen_string_literal: true

namespace :test do
  desc 'Run specs in hearth'
  task 'hearth' do
    sh('bundle exec rspec hearth/spec -I hearth/lib')
  end

  desc 'Run generated and hand written specs for the white_label sdk'
  task 'white_label' do
    sh("bundle exec rspec #{$white_label_dir}/spec -I #{$white_label_dir}/lib -I hearth/lib")
  end

  desc 'Run generated protocol specs for rpcv2_cbor'
  task 'rpcv2_cbor' do
    sh("bundle exec rspec #{$rpcv2_cbor_dir}/spec -I #{$rpcv2cbor_dir}/lib -I hearth/lib")
  end

  desc 'Run generated protocol specs for rails_json'
  task 'rails_json' do
    sh("bundle exec rspec #{$rails_json_dir}/spec -I #{$rails_json_dir}/lib -I hearth/lib")
  end

  desc 'Run generated tests taken from smithy (endpoint specs)'
  task 'smithy-core-endpoint-tests' do
    build_dir = 'codegen/smithy-ruby-codegen-test/build/smithyprojections/smithy-ruby-codegen-test'

    test_sdk_dirs = Dir.glob("#{build_dir}/*/ruby-codegen/*")
                       .select { |d| !d.include?('white_label') && Dir.exist?("#{d}/spec") }

    specs = test_sdk_dirs.map { |d| "#{d}/spec" }.join(' ')
    includes = test_sdk_dirs.map { |d|
      "-I #{d}/lib"
    }.join(' ') + ' -I hearth/lib'

    sh("bundle exec rspec #{specs} #{includes}")
  end
end
