# frozen_string_literal: true

require_relative '../spec_helper'

module Smithy
  module Client
    module Waiters
      describe Waiters do
        let(:shapes) do
          {
            'smithy.ruby.tests#WaitService' => {
              'type' => 'service',
              'version' => '2022-11-30',
              'operations' => [{ 'target' => 'smithy.ruby.tests#GetWidget' }],
              'traits' => { 'smithy.protocols#rpcv2Cbor' => {} }
            },
            'smithy.ruby.tests#GetWidget' => {
              'type' => 'operation',
              'input' => { 'target' => 'smithy.ruby.tests#WidgetInput' },
              'output' => { 'target' => 'smithy.ruby.tests#WidgetOutput' },
              'errors' => [{ 'target' => 'smithy.ruby.tests#MyError' }],
              'traits' => { 'smithy.waiters#waitable' => matchers }
            },
            'smithy.ruby.tests#WidgetInput' => {
              'type' => 'structure',
              'members' => {
                'stringProperty' => { 'target' => 'smithy.api#String' },
                'stringArrayProperty' => { 'target' => 'smithy.ruby.tests#StringArray' },
                'booleanProperty' => { 'target' => 'smithy.api#Boolean' },
                'booleanArrayProperty' => { 'target' => 'smithy.ruby.tests#BooleanArray' }
              }
            },
            'smithy.ruby.tests#WidgetOutput' => {
              'type' => 'structure',
              'members' => {
                'stringProperty' => { 'target' => 'smithy.api#String' },
                'stringArrayProperty' => { 'target' => 'smithy.ruby.tests#StringArray' },
                'booleanProperty' => { 'target' => 'smithy.api#Boolean' },
                'booleanArrayProperty' => { 'target' => 'smithy.ruby.tests#BooleanArray' }
              }
            },
            'smithy.ruby.tests#BooleanArray' => {
              'type' => 'list',
              'member' => { 'target' => 'smithy.api#Boolean' }
            },
            'smithy.ruby.tests#StringArray' => {
              'type' => 'list',
              'member' => { 'target' => 'smithy.api#String' }
            },
            'smithy.ruby.tests#MyError' => {
              'type' => 'structure',
              'members' => { 'message' => { 'target' => 'smithy.api#String' } },
              'traits' => { 'smithy.api#error' => 'client' }
            }
          }
        end

        let(:sample_client) { ClientHelper.sample_client(shapes: shapes) }

        let(:client_class) do
          client_class = sample_client.const_get(:Client)
          client_class.clear_plugins
          client_class.add_plugin(sample_client::Plugins::Endpoint)
          client_class.add_plugin(Smithy::Client::Plugins::Protocol)
          client_class.add_plugin(Smithy::Client::Plugins::RaiseResponseErrors)
          client_class.add_plugin(Smithy::Client::Plugins::StubResponses)
          client_class
        end

        let(:client) { client_class.new(stub_responses: true) }

        let(:input) { { string_property: 'input_string' } }

        let(:my_error) { sample_client::Errors::MyError.new(nil, nil) }

        before(:each) { allow_any_instance_of(Waiter).to receive(:sleep) }

        describe 'Waiter' do
          let(:matchers) do
            {
              'OutputStringPropertyMatcher' => {
                'acceptors' => [
                  {
                    'state' => 'success',
                    'matcher' => {
                      'output' => {
                        'path' => 'stringProperty',
                        'expected' => 'success',
                        'comparator' => 'stringEquals'
                      }
                    }
                  },
                  {
                    'state' => 'retry',
                    'matcher' => {
                      'output' => {
                        'path' => 'stringProperty',
                        'expected' => 'retry',
                        'comparator' => 'stringEquals'
                      }
                    }
                  },
                  {
                    'state' => 'failure',
                    'matcher' => {
                      'output' => {
                        'path' => 'stringProperty',
                        'expected' => 'failure',
                        'comparator' => 'stringEquals'
                      }
                    }
                  }
                ]
              }
            }
          end

          describe '#poll' do
            it 'delays when status is retry' do
              client.stub_responses(
                :get_widget,
                { string_property: 'retry' },
                { string_property: 'retry' },
                { string_property: 'success' }
              )
              expect_any_instance_of(Waiter).to receive(:delay).exactly(2).times.and_call_original
              client.wait_until(:output_string_property_matcher, input, max_wait_time: 60)
            end

            it 'raises a failure state error when status is failure' do
              client.stub_responses(:get_widget, { string_property: 'failure' })
              expect do
                client.wait_until(:output_string_property_matcher, input, max_wait_time: 60)
              end.to raise_error(FailureStateError)
            end

            it 'raises an unexpected error when status is error' do
              client.stub_responses(:get_widget, StandardError.new)
              expect do
                client.wait_until(:output_string_property_matcher, input, max_wait_time: 60)
              end.to raise_error(UnexpectedError)
            end

            it 'raises a max wait time exceeded error when there is no more remaining time' do
              client.stub_responses(
                :get_widget,
                { string_property: 'retry' },
                { string_property: 'retry' }
              )
              expect do
                client.wait_until(:output_string_property_matcher, input, max_wait_time: 1)
              end.to raise_error(MaxWaitTimeExceededError)
            end
          end

          describe '#delay' do
            it 'generates a random delay between min_delay and max_delay' do
              min_delay = 5
              max_delay = 60
              options = {
                max_wait_time: 60,
                min_delay: min_delay,
                max_delay: max_delay
              }
              output = Smithy::Client::Output.new(data: {})
              expect_any_instance_of(Poller).to receive(:call).and_return(
                [output, :retry], [output, :retry], [output, :retry], [output, :success]
              )
              expect_any_instance_of(Waiter).to receive(:delay).with(1).and_wrap_original do |m, *args|
                delay = m.call(*args)
                expect(delay.between?(min_delay, max_delay)).to be true
                0
              end
              expect_any_instance_of(Waiter).to receive(:delay).with(2).and_wrap_original do |m, *args|
                delay = m.call(*args)
                expect(delay.between?(min_delay, max_delay)).to be true
                0
              end
              expect_any_instance_of(Waiter).to receive(:delay).with(3).and_wrap_original do |m, *args|
                delay = m.call(*args)
                expect(delay.between?(min_delay, max_delay)).to be true
                0
              end
              client.wait_until(:output_string_property_matcher, input, options)
            end

            it 'sets the delay to remaining time for the last attempt' do
              remaining_time = 40
              min_delay = 25
              max_delay = 30
              options = {
                max_wait_time: remaining_time,
                min_delay: min_delay,
                max_delay: max_delay
              }
              output = Smithy::Client::Output.new(data: {})
              expect_any_instance_of(Poller).to receive(:call).and_return([output, :retry], [output, :success])
              expect_any_instance_of(Waiter).to receive(:delay).and_wrap_original do |m, *args|
                delay = m.call(*args)
                expect(delay).to eq(remaining_time)
                0
              end
              client.wait_until(:output_string_property_matcher, input, options)
            end
          end

          context 'errors' do
            it 'raises an error when max wait time is exceeded' do
              client.stub_responses(:get_widget, {})
              expect do
                client.wait_until(:output_string_property_matcher, input, max_wait_time: 0)
              end.to raise_error(MaxWaitTimeExceededError)
            end

            it 'raises an error when max_wait_time is not provided' do
              expect do
                client.wait_until(:output_string_property_matcher, input)
              end.to raise_error(ArgumentError, 'expected `:max_wait_time` to be an integer, got: ')
            end

            it 'raises an error when max_delay is less than 1' do
              options = {
                max_wait_time: 5,
                max_delay: 0
              }
              expect do
                client.wait_until(:output_string_property_matcher, input, options)
              end.to raise_error(ArgumentError, '`:max_delay` must be greater than 0')
            end

            it 'raises an error when min_delay is less than 1' do
              options = {
                max_wait_time: 5,
                min_delay: 0
              }
              expect do
                client.wait_until(:output_string_property_matcher, input, options)
              end.to raise_error(ArgumentError,
                                 '`:min_delay` must be greater than 0 and less than or equal to `:max_delay`')
            end

            it 'raises an error when max_delay is less than min_delay' do
              options = {
                max_wait_time: 5,
                min_delay: 4,
                max_delay: 2
              }
              expect do
                client.wait_until(:output_string_property_matcher, input, options)
              end.to raise_error(ArgumentError,
                                 '`:min_delay` must be greater than 0 and less than or equal to `:max_delay`')
            end
          end
        end

        describe 'Waiters::Poller' do
          context 'success matcher' do
            let(:matchers) do
              {
                'SuccessTrueMatcher' => {
                  'acceptors' => [{ 'state' => 'success', 'matcher' => { 'success' => true } }]
                },
                'SuccessFalseMatcher' => {
                  'acceptors' => [{ 'state' => 'success', 'matcher' => { 'success' => false } }]
                }
              }
            end

            it 'succeeds when success is set to true and successful response is received' do
              client.stub_responses(:get_widget, {})
              expect do
                client.wait_until(:success_true_matcher, input, max_wait_time: 60)
              end.to_not raise_error
            end

            it 'succeeds when success is set to false and error is received' do
              client.stub_responses(:get_widget, StandardError.new)
              expect do
                client.wait_until(:success_false_matcher, input, max_wait_time: 3)
              end.to_not raise_error
            end

            it 'retries and succeeds when matched' do
              client.stub_responses(
                :get_widget,
                {},
                {},
                StandardError
              )
              expect_any_instance_of(Waiter).to receive(:delay).twice.and_call_original
              expect do
                client.wait_until(:success_false_matcher, input, max_wait_time: 60)
              end.to_not raise_error
            end

            it 'fails when success is set to true and unexpected error is received' do
              client.stub_responses(:get_widget, StandardError)
              expect do
                client.wait_until(:success_true_matcher, input, max_wait_time: 60)
              end.to raise_error(UnexpectedError)
            end
          end

          context 'error type matcher' do
            let(:matchers) do
              {
                'ErrorTypeMatcher' => {
                  'acceptors' => [{ 'state' => 'success', 'matcher' => { 'errorType' => 'MyError' } }]
                },
                'AbsoluteErrorTypeMatcher' => {
                  'acceptors' => [{ 'state' => 'success', 'matcher' => { 'errorType' => 'smithy.ruby.tests#MyError' } }]
                }
              }
            end

            it 'succeeds when error matches for relative shape name' do
              client.stub_responses(:get_widget, my_error)
              expect do
                client.wait_until(:error_type_matcher, input, max_wait_time: 60)
              end.to_not raise_error
            end

            it 'succeeds when error matches for absolute shape id' do
              client.stub_responses(:get_widget, my_error)
              expect do
                client.wait_until(:absolute_error_type_matcher, input, max_wait_time: 60)
              end.to_not raise_error
            end

            it 'retries and succeeds when matched' do
              client.stub_responses(
                :get_widget,
                {},
                {},
                my_error
              )
              expect_any_instance_of(Waiter).to receive(:delay).twice.and_call_original
              expect do
                client.wait_until(:error_type_matcher, input, max_wait_time: 60)
              end.to_not raise_error
            end

            it 'fails when error does not match' do
              client.stub_responses(:get_widget, StandardError)
              expect do
                client.wait_until(:error_type_matcher, input, max_wait_time: 60)
              end.to raise_error(UnexpectedError)
            end
          end

          context 'output matcher' do
            context 'string equals comparator' do
              let(:matchers) do
                {
                  'OutputStringPropertyMatcher' => {
                    'acceptors' => [
                      {
                        'state' => 'success',
                        'matcher' => {
                          'output' => {
                            'path' => 'stringProperty',
                            'expected' => 'expected string',
                            'comparator' => 'stringEquals'
                          }
                        }
                      }
                    ]
                  }
                }
              end

              it 'succeeds when output matches' do
                client.stub_responses(:get_widget, { string_property: 'expected string' })
                expect do
                  client.wait_until(:output_string_property_matcher, input, max_wait_time: 60)
                end.to_not raise_error
              end

              it 'retries and succeeds when matched' do
                client.stub_responses(
                  :get_widget,
                  { string_property: 'unexpected string' },
                  { string_property: 'unexpected string' },
                  { string_property: 'expected string' }
                )
                expect_any_instance_of(Waiter).to receive(:delay).twice.and_call_original
                expect do
                  client.wait_until(:output_string_property_matcher, input, max_wait_time: 60)
                end.to_not raise_error
              end

              it 'fails when output property does not match' do
                client.stub_responses(:get_widget, { string_property: 'unexpected string' })
                expect do
                  client.wait_until(:output_string_property_matcher, input, max_wait_time: 0)
                end.to raise_error(MaxWaitTimeExceededError)
              end

              it 'fails when output property is nil' do
                client.stub_responses(:get_widget, {})
                expect do
                  client.wait_until(:output_string_property_matcher, input, max_wait_time: 0)
                end.to raise_error(MaxWaitTimeExceededError)
              end
            end

            context 'boolean equals comparator' do
              let(:matchers) do
                {
                  'OutputBooleanPropertyMatcher' => {
                    'acceptors' => [
                      {
                        'state' => 'success',
                        'matcher' => {
                          'output' => {
                            'path' => 'booleanProperty',
                            'expected' => 'false',
                            'comparator' => 'booleanEquals'
                          }
                        }
                      }
                    ]
                  }
                }
              end

              it 'succeeds when output matches' do
                client.stub_responses(:get_widget, { boolean_property: false })
                expect do
                  client.wait_until(:output_boolean_property_matcher, input, max_wait_time: 60)
                end.to_not raise_error
              end

              it 'retries and succeeds when matched' do
                client.stub_responses(
                  :get_widget,
                  { boolean_property: true },
                  { boolean_property: true },
                  { boolean_property: false }
                )
                expect_any_instance_of(Waiter).to receive(:delay).twice.and_call_original
                expect do
                  client.wait_until(:output_boolean_property_matcher, input, max_wait_time: 60)
                end.to_not raise_error
              end

              it 'fails when output property does not match' do
                client.stub_responses(:get_widget, { boolean_property: true })
                expect do
                  client.wait_until(:output_boolean_property_matcher, input, max_wait_time: 0)
                end.to raise_error(MaxWaitTimeExceededError)
              end

              it 'fails when output property is nil' do
                client.stub_responses(:get_widget, {})
                expect do
                  client.wait_until(:output_boolean_property_matcher, input, max_wait_time: 0)
                end.to raise_error(MaxWaitTimeExceededError)
              end
            end

            context 'all string equals comparator' do
              let(:matchers) do
                {
                  'OutputStringArrayAllPropertyMatcher' => {
                    'acceptors' => [
                      {
                        'state' => 'success',
                        'matcher' => {
                          'output' => {
                            'path' => 'stringArrayProperty',
                            'expected' => 'expected string',
                            'comparator' => 'allStringEquals'
                          }
                        }
                      }
                    ]
                  }
                }
              end

              it 'succeeds when output matches' do
                output = {
                  string_array_property: [
                    'expected string',
                    'expected string',
                    'expected string'
                  ]
                }
                client.stub_responses(:get_widget, output)
                expect do
                  client.wait_until(:output_string_array_all_property_matcher, input, max_wait_time: 60)
                end.to_not raise_error
              end

              it 'retries and succeeds when matched' do
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
                client.stub_responses(
                  :get_widget,
                  output_unexpected,
                  output_unexpected,
                  output_expected
                )
                expect_any_instance_of(Waiter).to receive(:delay).twice.and_call_original
                expect do
                  client.wait_until(:output_string_array_all_property_matcher, input, max_wait_time: 60)
                end.to_not raise_error
              end

              it 'fails when output property does not match' do
                output_unexpected = {
                  string_array_property: [
                    'expected string',
                    'unexpected string',
                    'unexpected string'
                  ]
                }
                client.stub_responses(:get_widget, output_unexpected)
                expect do
                  client.wait_until(:output_string_array_all_property_matcher, input, max_wait_time: 0)
                end.to raise_error(MaxWaitTimeExceededError)
              end

              it 'fails when output property is empty' do
                client.stub_responses(:get_widget, { string_array_property: [] })
                expect do
                  client.wait_until(:output_string_array_all_property_matcher, input, max_wait_time: 0)
                end.to raise_error(MaxWaitTimeExceededError)
              end

              it 'fails when output property is nil' do
                client.stub_responses(:get_widget, {})
                expect do
                  client.wait_until(:output_string_array_all_property_matcher, input, max_wait_time: 0)
                end.to raise_error(MaxWaitTimeExceededError)
              end
            end

            context 'any string equals comparator' do
              let(:matchers) do
                {
                  'OutputStringArrayAnyPropertyMatcher' => {
                    'acceptors' => [
                      {
                        'state' => 'success',
                        'matcher' => {
                          'output' => {
                            'path' => 'stringArrayProperty',
                            'expected' => 'expected string',
                            'comparator' => 'anyStringEquals'
                          }
                        }
                      }
                    ]
                  }
                }
              end

              it 'succeeds when output matches' do
                output = {
                  string_array_property: [
                    'some other string',
                    'another string',
                    'expected string',
                    'yet another string'
                  ]
                }
                client.stub_responses(:get_widget, output)
                expect do
                  client.wait_until(:output_string_array_any_property_matcher, input, max_wait_time: 60)
                end.to_not raise_error
              end

              it 'retries and succeeds when matched' do
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
                client.stub_responses(
                  :get_widget,
                  output_unexpected,
                  output_unexpected,
                  output_expected
                )
                expect_any_instance_of(Waiter).to receive(:delay).twice.and_call_original
                expect do
                  client.wait_until(:output_string_array_any_property_matcher, input, max_wait_time: 60)
                end.to_not raise_error
              end

              it 'fails when output property does not match' do
                output_unexpected = {
                  string_array_property: [
                    'some other string',
                    'another string',
                    'unexpected string',
                    'yet another string'
                  ]
                }
                client.stub_responses(:get_widget, output_unexpected)
                expect do
                  client.wait_until(:output_string_array_any_property_matcher, input, max_wait_time: 0)
                end.to raise_error(MaxWaitTimeExceededError)
              end

              it 'fails when output property is empty' do
                client.stub_responses(:get_widget, { string_array_property: [] })
                expect do
                  client.wait_until(:output_string_array_any_property_matcher, input, max_wait_time: 0)
                end.to raise_error(MaxWaitTimeExceededError)
              end

              it 'fails when output property is nil' do
                client.stub_responses(:get_widget, {})
                expect do
                  client.wait_until(:output_string_array_any_property_matcher, input, max_wait_time: 0)
                end.to raise_error(MaxWaitTimeExceededError)
              end
            end
          end

          context 'input output matcher' do
            let(:matchers) do
              {
                'InputOutputBooleanPropertyMatcher' => {
                  'acceptors' => [
                    {
                      'state' => 'success',
                      'matcher' => {
                        'inputOutput' => {
                          'path' => 'input.stringProperty == output.stringProperty',
                          'expected' => 'true',
                          'comparator' => 'booleanEquals'
                        }
                      }
                    }
                  ]
                }
              }
            end

            it 'succeeds for boolean equals comparator' do
              client.stub_responses(:get_widget, { string_property: 'input_string' })
              expect do
                client.wait_until(:input_output_boolean_property_matcher, input, max_wait_time: 60)
              end.to_not raise_error
            end
          end

          context 'order' do
            let(:matchers) do
              {
                'AcceptorOrderSuccessMatcher' => {
                  'acceptors' => [
                    { 'state' => 'success', 'matcher' => { 'errorType' => 'MyError' } },
                    { 'state' => 'failure', 'matcher' => { 'errorType' => 'MyError' } }
                  ]
                },
                'AcceptorOrderFailureMatcher' => {
                  'acceptors' => [
                    { 'state' => 'failure', 'matcher' => { 'errorType' => 'MyError' } },
                    { 'state' => 'success', 'matcher' => { 'errorType' => 'MyError' } }
                  ]
                }
              }
            end

            it 'checks acceptors in order' do
              client.stub_responses(:get_widget, my_error)
              expect do
                client.wait_until(:acceptor_order_success_matcher, input, max_wait_time: 60)
              end.to_not raise_error
              client.stub_responses(:get_widget, my_error)
              expect do
                client.wait_until(:acceptor_order_failure_matcher, input, max_wait_time: 60)
              end.to raise_error(FailureStateError)
            end
          end
        end
      end
    end
  end
end
