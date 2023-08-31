# frozen_string_literal: true

require_relative 'spec_helper'

module WhiteLabel
  describe Client do
    let(:config) { Config.new(stub_responses: true, validate_input: false) }
    let(:client) { Client.new(config) }
    let(:before_send) do
      Class.new(Hearth::Interceptor) do
        def initialize(&block)
          @block = block
          super
        end

        def read_before_transmit(context)
          @block.call(context)
        end
      end
    end

    describe '#endpoint_operation' do
      it 'prepends to the host' do
        interceptor = before_send.new do |context|
          expect(context.request.uri.to_s).to include('foo')
        end
        client.endpoint_operation({}, interceptors: [interceptor])
      end
    end

    describe '#endpoint_with_host_label_operation' do
      let(:label) { 'input_label' }

      it 'raises when missing host label member' do
        expect { client.endpoint_with_host_label_operation }
          .to raise_error(
            ArgumentError,
            'Host label label_member cannot be nil or empty.'
          )
      end

      it 'prepends the label to the host' do
        interceptor = before_send.new do |context|
          expect(context.request.uri.to_s).to include("foo.#{label}")
        end
        client.endpoint_with_host_label_operation(
          { label_member: label },
          interceptors: [interceptor]
        )
      end
    end
  end
end
