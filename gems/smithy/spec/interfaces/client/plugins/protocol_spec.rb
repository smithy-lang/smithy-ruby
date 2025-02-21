# frozen_string_literal: true

# TODO: Need to add more test cases once protocol ordering is supported
describe 'Client: Protocol Plugin', rbs_test: true do
  # rubocop:disable Lint/UselessAssignment
  before(:all) do
    # Define Weld classes (scoped to this block only)
    DummyProtocol = Class.new

    used = Class.new(Smithy::Weld) do
      def for?(service)
        service.keys.first == 'smithy.ruby.tests#ProtocolService'
      end

      def protocols
        { 'smithy.ruby.tests#fakeProtocol' => DummyProtocol }
      end
    end
  end
  # rubocop:enable Lint/UselessAssignment

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
