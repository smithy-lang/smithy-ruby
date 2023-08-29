# frozen_string_literal: true

require_relative 'spec_helper'

module WhiteLabel
  describe Client do
    context 'relative middleware ordering' do
      it 'allows a middleware to be set before their relative' do
        config = Config.new(
          stub_responses: true,
          verify_in_mid: proc { |metadata|
            expect(metadata[:before_middleware]).to be(true)
          }
        )
        client = Client.new(config)
        client.request_compression_operation({ body: 'foo' })
      end

      it 'allows a middleware to be set after their relative and ' \
         'a second middleware to be set when their relative is optional' do
        config = Config.new(
          stub_responses: true,
          verify_in_after: proc { |metadata|
            expect(metadata[:mid_middleware]).to be(true)
          }
        )
        client = Client.new(config)
        client.request_compression_operation({ body: 'foo' })
      end
    end
  end
end
