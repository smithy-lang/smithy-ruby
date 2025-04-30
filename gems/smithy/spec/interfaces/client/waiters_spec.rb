# frozen_string_literal: true

require_relative '../../spec_helper'

describe 'Client: Waiters' do
  let(:input) { { string_property: 'input_string' } }
  let(:client) { Wait_Service::Client.new(stub_responses: true) }
  let(:waiter) { Smithy::Client::Waiters::Waiter }
  let(:my_error) { Wait_Service::Errors::MyError.new({}, message: 'my error message') }
  let(:widget_does_not_exist_error) {
    Wait_Service::Errors::WidgetDoesNotExist.new({}, message: 'widget does not exist message')
  }
  let(:unexpected_error) { Smithy::Client::Waiters::Errors::UnexpectedError }
  let(:failure_state_error) { Smithy::Client::Waiters::Errors::FailureStateError }
  let(:max_wait_time_exceeded_error) { Smithy::Client::Waiters::Errors::MaxWaitTimeExceededError }

  ['generated client gem'].each do |context|
    context context do
      include_context context, 'Wait_Service'

      describe 'code generated waiters' do
        context 'success matcher' do
          it 'waits successfully when set to true' do
            output = {}
            expect(client).to receive(:get_widget).and_return(output)
            expect {
              client.wait_until(:success_true_matcher, input, max_wait_time: 60)
            }.to_not raise_error
          end

          it 'waits successfully when set to false' do
            expect(client).to receive(:get_widget).and_raise(StandardError)
            expect {
              client.wait_until(:success_false_matcher, input, max_wait_time: 60)
            }.to_not raise_error
          end

          it 'retries until successful' do
            output = {}
            3.times do
              expect(client).to receive(:get_widget).and_return(output)
              expect_any_instance_of(waiter).to receive(:delay).and_call_original
            end
            expect(client).to receive(:get_widget).and_raise(StandardError)
            expect {
              client.wait_until(:success_false_matcher, input, max_wait_time: 60)
            }.to_not raise_error
          end

          it 'fails when set to true and unexpected error is encountered' do
            expect(client).to receive(:get_widget).and_raise(StandardError)
            expect {
              client.wait_until(:success_true_matcher, input, max_wait_time: 60)
            }.to raise_error(unexpected_error)
          end

          it 'fails when max wait time is exceeded' do
            output = {}
            5.times do
              allow(client).to receive(:get_widget).and_return(output)
            end
            expect {
              client.wait_until(:success_false_matcher, input, max_wait_time: 10)
            }.to raise_error(max_wait_time_exceeded_error)
          end
        end

        context 'error type matcher' do
          it 'waits successfully when error matches' do
            expect(client).to receive(:get_widget).and_raise(my_error)
            expect {
              client.wait_until(:error_type_matcher, input, max_wait_time: 60)
            }.to_not raise_error
          end

          it 'retries until successful' do
            output = {}
            3.times do
              expect(client).to receive(:get_widget).and_return(output)
              expect_any_instance_of(waiter).to receive(:delay).and_call_original
            end
            expect(client).to receive(:get_widget).and_raise(my_error)
            expect {
              client.wait_until(:error_type_matcher, input, max_wait_time: 60)
            }.to_not raise_error
          end

          it 'fails when error does not match' do
            expect(client).to receive(:get_widget).and_raise(StandardError)
            expect {
              client.wait_until(:error_type_matcher, input, max_wait_time: 60)
            }.to raise_error(unexpected_error)
          end

          it 'fails when max wait time is exceeded' do
            output = {}
            5.times do
              allow(client).to receive(:get_widget).and_return(output)
            end
            expect {
              client.wait_until(:error_type_matcher, input, max_wait_time: 10)
            }.to raise_error(max_wait_time_exceeded_error)
          end
        end

        context 'output matcher' do
          context 'string equals comparator' do
            it 'waits successfully' do
              output = { string_property: 'expected string' }
              expect(client).to receive(:get_widget).and_return(output)
              expect {
                client.wait_until(:output_string_property_matcher, input, max_wait_time: 60)
              }.to_not raise_error
            end

            it 'retries until successful' do
              output_expected = { string_property: 'expected string' }
              output_unexpected = { string_property: 'unexpected string' }
              3.times do
                expect(client).to receive(:get_widget).and_return(output_unexpected)
                expect_any_instance_of(waiter).to receive(:delay).and_call_original
              end
              expect(client).to receive(:get_widget).and_return(output_expected)
              expect {
                client.wait_until(:output_string_property_matcher, input, max_wait_time: 60)
              }.to_not raise_error
            end
          end

          context 'boolean equals comparator' do
            it 'waits successfully' do
              output = { boolean_property: false }
              expect(client).to receive(:get_widget).and_return(output)
              expect {
                client.wait_until(:output_boolean_property_matcher, input, max_wait_time: 60)
              }.to_not raise_error
            end

            it 'retries until successful' do
              output_expected = { boolean_property: false }
              output_unexpected = { boolean_property: true }
              3.times do
                expect(client).to receive(:get_widget).and_return(output_unexpected)
                expect_any_instance_of(waiter).to receive(:delay).and_call_original
              end
              expect(client).to receive(:get_widget).and_return(output_expected)
              expect {
                client.wait_until(:output_boolean_property_matcher, input, max_wait_time: 60)
              }.to_not raise_error
            end
          end

          context 'all string equals comparator' do
            it 'waits successfully' do
              output = {
                string_array_property: [
                  'expected string',
                  'expected string',
                  'expected string'
                ]
              }
              expect(client).to receive(:get_widget).and_return(output)
              expect {
                client.wait_until(:output_string_array_all_property_matcher, input, max_wait_time: 60)
              }.to_not raise_error
            end

            it 'retries until successful' do
              output_expected = {
                string_array_property: [
                  'expected string',
                  'expected string',
                  'expected string'
                ]
              }
              output_unexpected = {
                string_array_property: [
                  'expected string',
                  'unexpected string',
                  'unexpected string'
                ]
              }
              3.times do
                expect(client).to receive(:get_widget).and_return(output_unexpected)
                expect_any_instance_of(waiter).to receive(:delay).and_call_original
              end
              expect(client).to receive(:get_widget).and_return(output_expected)
              expect {
                client.wait_until(:output_string_array_all_property_matcher, input, max_wait_time: 60)
              }.to_not raise_error
            end
          end

          context 'any string equals comparator' do
            it 'waits successfully' do
              output = {
                string_array_property: [
                  'some other string',
                  'another string',
                  'expected string',
                  'yet another string'
                ]
              }
              expect(client).to receive(:get_widget).and_return(output)
              expect {
                client.wait_until(:output_string_array_any_property_matcher, input, max_wait_time: 60)
              }.to_not raise_error
            end

            it 'retries until successful' do
              output_expected = {
                string_array_property: [
                  'some other string',
                  'another string',
                  'expected string',
                  'yet another string'
                ]
              }
              output_unexpected = {
                string_array_property: [
                  'some other string',
                  'another string',
                  'unexpected string',
                  'yet another string'
                ]
              }
              3.times do
                expect(client).to receive(:get_widget).and_return(output_unexpected)
                expect_any_instance_of(waiter).to receive(:delay).and_call_original
              end
              expect(client).to receive(:get_widget).and_return(output_expected)
              expect {
                client.wait_until(:output_string_array_any_property_matcher, input, max_wait_time: 60)
              }.to_not raise_error
            end
          end
        end

        context 'input output matcher' do
          # it 'waits successfully for string equals comparator' do
          #   output = { string_property: 'input_string' }
          #   expect(client).to receive(:get_widget).and_return(output)
          #   expect {
          #     client.wait_until(:input_output_string_property_matcher, input, max_wait_time: 60)
          #   }.to_not raise_error
          # end

          it 'waits successfully for boolean equals comparator' do
            output = { string_property: 'input_string' }
            expect(client).to receive(:get_widget).and_return(output)
            expect {
              client.wait_until(:input_output_boolean_property_matcher, input, max_wait_time: 60)
            }.to_not raise_error
          end

          # it 'waits successfully for all string equals comparator' do
          #   input = :input
          #   input['string_array_property'] = [
          #     'expected string',
          #     'expected string',
          #     'expected string'
          #   ]
          #   output = {
          #     string_array_property: [
          #       'expected string',
          #       'expected string',
          #       'expected string'
          #     ]
          #   }
          #   expect(client).to receive(:get_widget).and_return(output)
          #   expect {
          #     client.wait_until(:input_output_string_array_all_property_matcher, input, max_wait_time: 60)
          #   }.to_not raise_error
          # end
          #
          # it 'waits successfully for any string equals comparator' do
          #   input = :input
          #   input['string_array_property'] = [
          #     'expected string',
          #   ]
          #   output = {
          #     string_array_property: [
          #       'some other string',
          #       'another string',
          #       'expected string',
          #       'yet another string'
          #     ]
          #   }
          #   expect(client).to receive(:get_widget).and_return(output)
          #   expect {
          #     client.wait_until(:input_output_string_array_any_property_matcher, input, max_wait_time: 60)
          #   }.to_not raise_error
          # end
        end

        it 'checks acceptors in order' do
          expect(client).to receive(:delete_widget).and_raise(widget_does_not_exist_error)
          expect {
            client.wait_until(:acceptor_order_success_matcher, input, max_wait_time: 60)
          }.to_not raise_error

          expect(client).to receive(:delete_widget).and_raise(widget_does_not_exist_error)
          expect {
            client.wait_until(:acceptor_order_failure_matcher, input, max_wait_time: 60)
          }.to raise_error(failure_state_error)
        end
      end

      describe 'runtime generated waiters' do
        context 'success matcher' do
          it 'waits successfully when set to true' do
            output = {}
            expect(client).to receive(:get_widget).and_return(output)
            expect {
              client.wait_until_custom(:success_true_matcher, input, max_wait_time: 60)
            }.to_not raise_error
          end

          it 'waits successfully when set to false' do
            expect(client).to receive(:get_widget).and_raise(StandardError)
            expect {
              client.wait_until_custom(:success_false_matcher, input, max_wait_time: 60)
            }.to_not raise_error
          end
        end


        context 'error type matcher' do
          it 'waits successfully when error matches' do
            expect(client).to receive(:get_widget).and_raise(my_error)
            expect {
              client.wait_until_custom(:error_type_matcher, input, max_wait_time: 60)
            }.to_not raise_error
          end
        end

        context 'output matcher' do
          it 'waits successfully for string equals comparator' do
            output = { string_property: 'expected string' }
            expect(client).to receive(:get_widget).and_return(output)
            expect {
              client.wait_until_custom(:output_string_property_matcher, input, max_wait_time: 60)
            }.to_not raise_error
          end

          it 'waits successfully for boolean equals comparator' do
            output = { boolean_property: false }
            expect(client).to receive(:get_widget).and_return(output)
            expect {
              client.wait_until_custom(:output_boolean_property_matcher, input, max_wait_time: 60)
            }.to_not raise_error
          end

          it 'waits successfully for all string equals comparator' do
            output = {
              string_array_property: [
                'expected string',
                'expected string',
                'expected string'
              ]
            }
            expect(client).to receive(:get_widget).and_return(output)
            expect {
              client.wait_until_custom(:output_string_array_all_property_matcher, input, max_wait_time: 60)
            }.to_not raise_error
          end

          it 'waits successfully for any string equals comparator' do
            output = {
              string_array_property: [
                'some other string',
                'another string',
                'expected string',
                'yet another string'
              ]
            }
            expect(client).to receive(:get_widget).and_return(output)
            expect {
              client.wait_until_custom(:output_string_array_any_property_matcher, input, max_wait_time: 60)
            }.to_not raise_error
          end
        end

        context 'input output matcher' do
          # it 'waits successfully for string equals comparator' do
          #   output = { string_property: 'input_string' }
          #   expect(client).to receive(:get_widget).and_return(output)
          #   expect {
          #     client.wait_until_custom(:input_output_string_property_matcher, input, max_wait_time: 60)
          #   }.to_not raise_error
          # end

          it 'waits successfully for boolean equals comparator' do
            output = { string_property: 'input_string' }
            expect(client).to receive(:get_widget).and_return(output)
            expect {
              client.wait_until_custom(:input_output_boolean_property_matcher, input, max_wait_time: 60)
            }.to_not raise_error
          end

          # it 'waits successfully for all string equals comparator' do
          #   input = :input
          #   input['string_array_property'] = [
          #     'expected string',
          #     'expected string',
          #     'expected string'
          #   ]
          #   output = {
          #     string_array_property: [
          #       'expected string',
          #       'expected string',
          #       'expected string'
          #     ]
          #   }
          #   expect(client).to receive(:get_widget).and_return(output)
          #   expect {
          #     client.wait_until_custom(:input_output_string_array_all_property_matcher, input, max_wait_time: 60)
          #   }.to_not raise_error
          # end
          #
          # it 'waits successfully for any string equals comparator' do
          #   input = :input
          #   input['string_array_property'] = [
          #     'expected string',
          #   ]
          #   output = {
          #     string_array_property: [
          #       'some other string',
          #       'another string',
          #       'expected string',
          #       'yet another string'
          #     ]
          #   }
          #   expect(client).to receive(:get_widget).and_return(output)
          #   expect {
          #     client.wait_until_custom(:input_output_string_array_any_property_matcher, input, max_wait_time: 60)
          #   }.to_not raise_error
          # end
        end
      end
    end
  end
end