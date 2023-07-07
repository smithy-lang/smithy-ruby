# frozen_string_literal: true

require_relative 'spec_helper'

module WhiteLabel
  describe Client do
    let(:test_interceptor) do
      Class.new do
        def read_before_execution(context); end
      end.new
    end

    describe 'client configured interceptor' do
      it 'calls interceptor hook' do
        config = Config.new(
          stub_responses: true,
          interceptors: Hearth::InterceptorList.new([test_interceptor])
        )
        client = Client.new(config)

        expect(test_interceptor).to receive(:read_before_execution)
          .with(instance_of(Hearth::InterceptorContext))

        client.kitchen_sink()
      end
    end
  end
end
