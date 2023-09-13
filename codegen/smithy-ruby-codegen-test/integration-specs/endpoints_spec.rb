# frozen_string_literal: true

require_relative 'spec_helper'

module WhiteLabel
  describe Client do
    let(:client) { Client.new(stub_responses: true, validate_input: false) }

    describe '#endpoint_operation' do
      it 'prepends to the host' do
        proc = proc do |context|
          expect(context.request.uri.to_s).to include('foo')
        end
        interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
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
        proc = proc do |context|
          expect(context.request.uri.to_s).to include("foo.#{label}")
        end
        interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
        client.endpoint_with_host_label_operation(
          { label_member: label },
          interceptors: [interceptor]
        )
      end
    end
  end
end
