
require_relative 'spec_helper'

module WhiteLabel
  describe Client do
    let(:client) { Client.new(stub_responses:  true) }

    describe '#endpoint_operation' do
      it 'prepends to the host' do
        middleware = Hearth::MiddlewareBuilder.before_send do |_, context|
          expect(context.request.url).to include('foo')
        end
        client.endpoint_operation( {}, middleware: middleware)
      end
    end

    describe '#endpoint_with_host_label_operation' do
      let(:label) { 'input_label' }

      it 'raises when missing host label member' do
        expect do
          client.endpoint_with_host_label_operation
        end.to raise_error(
                 ArgumentError,
                 "Host label label_member cannot be nil or empty.")
      end

      it 'prepends the label to the host' do
        middleware = Hearth::MiddlewareBuilder.before_send do |_, context|
          expect(context.request.url).to include("foo.#{label}")
        end
        client.endpoint_with_host_label_operation( {label_member: label}, middleware: middleware)
      end
    end
  end
end