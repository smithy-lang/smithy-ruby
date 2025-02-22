# frozen_string_literal: true

# TODO: Need to add more test cases once protocol ordering is supported
describe 'Client: Protocol Plugin', rbs_test: true do
  ['generated client gem', 'generated client from source code'].each do |context|
    next if ENV['SMITHY_RUBY_RBS_TEST'] && context != 'generated client gem'

    include_examples 'protocol plugin', context
  end
end
