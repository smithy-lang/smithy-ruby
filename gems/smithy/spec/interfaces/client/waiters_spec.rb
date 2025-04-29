# frozen_string_literal: true

require_relative '../../spec_helper'

describe 'Client: Waiters' do
  let(:client) { Wait_Service::Client.new(stub_responses: true) }

  ['generated client gem'].each do |context|
    context context do
      include_context context, 'Wait_Service'

      it 'generates waiters' do
        input = { string_property: 'prop' }
        output = {
          string_property: 'string',
          string_array_property: ['string'],
          boolean_property: true,
          boolean_array_property: [true],
          children: [
            {
              grandchildren:  [
                {
                  string_property: 'string',
                  boolean_property: true,
                }
              ]
            }
          ],
          dataMap: { key: 'key', value: 'value' },
        }
        expect(client).to receive(:get_widget).and_return(output)
        client.wait_until(:success_true_matcher, input, max_wait_time: 60)
      end

      it 'generates waiters again' do
        input = { string_property: 'prop' }
        expect(client).to receive(:get_widget).and_raise(Wait_Service::Errors::MyError.new({}, message: 'Error message'))
        # client.wait_until(:success_true_matcher, input, max_wait_time: 60)

        expect {
          client.wait_until(:success_true_matcher, input, max_wait_time: 60)
        }.to raise_error(Smithy::Client::Waiters::Errors::UnexpectedError)
      end

      it 'generates waiters again again' do
        input = { string_property: 'prop' }
        expect(client).to receive(:get_widget).and_raise(Wait_Service::Errors::MyError.new({}, message: 'Error message'))
        # client.wait_until(:success_true_matcher, input, max_wait_time: 60)

        expect {
          client.wait_until(:success_false_matcher, input, max_wait_time: 60)
        }.not_to raise_error
      end

      it 'generates waiters again again again' do
        input = { string_property: 'prop' }
        expect(client).to receive(:get_widget).and_raise(Wait_Service::Errors::MyError.new({}, message: 'Error message'))
        # client.wait_until(:success_true_matcher, input, max_wait_time: 60)

        expect {
          client.wait_until(:error_type_matcher, input, max_wait_time: 60)
        }.not_to raise_error
      end

      it 'generates waiters again again again again' do
        input = { string_property: 'prop' }
        expect(client).to receive(:delete_widget).twice.and_raise(Wait_Service::Errors::MyError.new({}, message: 'Error message'))
        expect(client).to receive(:delete_widget).once.and_raise(Wait_Service::Errors::WidgetDoesNotExist.new({}, message: 'Widget does not exist'))
        expect {
          client.wait_until(:multiple_acceptors_matcher, input, max_wait_time: 60)
        }.not_to raise_error
      end

      it 'matches output' do
        input = { string_property: 'prop' }
        output = {
          string_property: 'payload property contents',
          string_array_property: ['string'],
          boolean_property: true,
          boolean_array_property: [true],
          children: [
            {
              grandchildren:  [
                {
                  string_property: 'string',
                  boolean_property: true,
                }
              ]
            }
          ],
          dataMap: { key: 'key', value: 'value' },
        }
        expect(client).to receive(:get_widget).and_return(output)
        client.wait_until(:output_string_property_matcher, input, max_wait_time: 60)
      end

      it 'matches inputoutput' do
        input = { string_property: 'prop' }
        output = {
          string_property: 'prop',
          string_array_property: ['string'],
          boolean_property: true,
          boolean_array_property: [true],
          children: [
            {
              grandchildren:  [
                {
                  string_property: 'string',
                  boolean_property: true,
                }
              ]
            }
          ],
          dataMap: { key: 'key', value: 'value' },
        }
        expect(client).to receive(:get_widget).and_return(output)
        client.wait_until(:input_output_property_matcher, input, max_wait_time: 60)
      end
    end
  end
end