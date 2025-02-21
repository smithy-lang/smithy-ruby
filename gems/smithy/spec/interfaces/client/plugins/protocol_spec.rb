# frozen_string_literal: true

describe 'Client: Protocol Plugin', rbs_test: true do
  ['generated client gem', 'generated client from source code'].each do |context|
    next if ENV['SMITHY_RUBY_RBS_TEST'] && context != 'generated client gem'

    [
      { fixture: 'protocols/one_protocol', protocol_set: true },
      { fixture: 'protocols/no_protocol' }
    ].each do |fixture|
      include_examples 'protocol plugin', context, fixture
    end

  end
end
