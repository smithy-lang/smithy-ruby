# frozen_string_literal: true

require_relative 'spec_helper'

# Tests the order of middlewares within the WhiteLabelTestIntegration
module WhiteLabel
  describe Client do
    context 'relative middleware ordering' do
      it 'allows a specific order of middleware to their relatives and ' \
         'a middleware to be set when their relative is optional' do
        config = Config.new(stub_responses: true)
        client = Client.new(config)
        output = client.relative_middleware_operation
        expect(output.metadata[:middleware_order])
          .to eq(
            [
              WhiteLabel::Middleware::BeforeMiddleware,
              WhiteLabel::Middleware::MidMiddleware,
              WhiteLabel::Middleware::AfterMiddleware
            ]
          )
      end
    end
  end
end
