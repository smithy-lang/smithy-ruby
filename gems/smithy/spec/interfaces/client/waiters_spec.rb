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
  let(:no_such_waiter_error) { Smithy::Client::Waiters::Errors::NoSuchWaiterError }

  ['generated client gem'].each do |context|
    context context do
      include_context context, 'Wait_Service'

      describe 'code generated waiters' do
        context 'success matcher' do
          it 'waits successfully when set to true and receives successful response' do
            output = {}
            expect(client).to receive(:get_widget).and_return(output)
            expect {
              client.wait_until(:success_true_matcher, input, max_wait_time: 60)
            }.to_not raise_error
          end

          it 'waits successfully when set to false and error is encountered' do
            expect(client).to receive(:get_widget).and_raise(StandardError)
            expect {
              client.wait_until(:success_false_matcher, input, max_wait_time: 60)
            }.to_not raise_error
          end

          it 'retries and succeeds when match' do
            output = {}
            2.times do
              expect(client).to receive(:get_widget).and_return(output)
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
              client.wait_until(:success_false_matcher, input, max_wait_time: 2)
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

          it 'retries and succeeds when match' do
            output = {}
            2.times do
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
              client.wait_until(:error_type_matcher, input, max_wait_time: 2)
            }.to raise_error(max_wait_time_exceeded_error)
          end
        end

        context 'output matcher' do
          context 'string equals comparator' do
            it 'waits successfully when output matches' do
              output = { string_property: 'expected string' }
              expect(client).to receive(:get_widget).and_return(output)
              expect {
                client.wait_until(:output_string_property_matcher, input, max_wait_time: 60)
              }.to_not raise_error
            end

            it 'retries and succeeds when match' do
              output_expected = { string_property: 'expected string' }
              output_unexpected = { string_property: 'unexpected string' }
              2.times do
                expect(client).to receive(:get_widget).and_return(output_unexpected)
                expect_any_instance_of(waiter).to receive(:delay).and_call_original
              end
              expect(client).to receive(:get_widget).and_return(output_expected)
              expect {
                client.wait_until(:output_string_property_matcher, input, max_wait_time: 60)
              }.to_not raise_error
            end

            it 'fails when output property does not match' do
              output_unexpected = { string_property: 'unexpected string' }
              2.times do
                allow(client).to receive(:get_widget).and_return(output_unexpected)
              end
              expect {
                client.wait_until(:output_string_property_matcher, input, max_wait_time: 2)
              }.to raise_error(max_wait_time_exceeded_error)
            end

            it 'fails when output property is null' do
              output_unexpected = {}
              2.times do
                allow(client).to receive(:get_widget).and_return(output_unexpected)
              end
              expect {
                client.wait_until(:output_string_property_matcher, input, max_wait_time: 2)
              }.to raise_error(max_wait_time_exceeded_error)
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

            it 'retries and succeeds when match' do
              output_expected = { boolean_property: false }
              output_unexpected = { boolean_property: true }
              2.times do
                expect(client).to receive(:get_widget).and_return(output_unexpected)
                expect_any_instance_of(waiter).to receive(:delay).and_call_original
              end
              expect(client).to receive(:get_widget).and_return(output_expected)
              expect {
                client.wait_until(:output_boolean_property_matcher, input, max_wait_time: 60)
              }.to_not raise_error
            end

            it 'fails when output property does not match' do
              output_unexpected = { boolean_property: true }
              2.times do
                allow(client).to receive(:get_widget).and_return(output_unexpected)
              end
              expect {
                client.wait_until(:output_boolean_property_matcher, input, max_wait_time: 2)
              }.to raise_error(max_wait_time_exceeded_error)
            end

            it 'fails when output property is null' do
              output_unexpected = {}
              2.times do
                allow(client).to receive(:get_widget).and_return(output_unexpected)
              end
              expect {
                client.wait_until(:output_boolean_property_matcher, input, max_wait_time: 2)
              }.to raise_error(max_wait_time_exceeded_error)
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

            it 'retries and succeeds when match' do
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
              2.times do
                expect(client).to receive(:get_widget).and_return(output_unexpected)
                expect_any_instance_of(waiter).to receive(:delay).and_call_original
              end
              expect(client).to receive(:get_widget).and_return(output_expected)
              expect {
                client.wait_until(:output_string_array_all_property_matcher, input, max_wait_time: 60)
              }.to_not raise_error
            end

            it 'fails when output property does not match' do
              output_unexpected = {
                string_array_property: [
                  'expected string',
                  'unexpected string',
                  'unexpected string'
                ]
              }
              2.times do
                allow(client).to receive(:get_widget).and_return(output_unexpected)
              end
              expect {
                client.wait_until(:output_string_array_all_property_matcher, input, max_wait_time: 2)
              }.to raise_error(max_wait_time_exceeded_error)
            end

            it 'fails when output property is empty' do
              output_unexpected = { string_array_property: [] }
              2.times do
                allow(client).to receive(:get_widget).and_return(output_unexpected)
              end
              expect {
                client.wait_until(:output_string_array_all_property_matcher, input, max_wait_time: 2)
              }.to raise_error(max_wait_time_exceeded_error)
            end

            it 'fails when output property is null' do
              output_unexpected = {}
              2.times do
                allow(client).to receive(:get_widget).and_return(output_unexpected)
              end
              expect {
                client.wait_until(:output_string_array_all_property_matcher, input, max_wait_time: 2)
              }.to raise_error(max_wait_time_exceeded_error)
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

            it 'retries and succeeds when match' do
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
              2.times do
                expect(client).to receive(:get_widget).and_return(output_unexpected)
                expect_any_instance_of(waiter).to receive(:delay).and_call_original
              end
              expect(client).to receive(:get_widget).and_return(output_expected)
              expect {
                client.wait_until(:output_string_array_any_property_matcher, input, max_wait_time: 60)
              }.to_not raise_error
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
              2.times do
                allow(client).to receive(:get_widget).and_return(output_unexpected)
              end
              expect {
                client.wait_until(:output_string_array_any_property_matcher, input, max_wait_time: 2)
              }.to raise_error(max_wait_time_exceeded_error)
            end

            it 'fails when output property is empty' do
              output_unexpected = { string_array_property: [] }
              2.times do
                allow(client).to receive(:get_widget).and_return(output_unexpected)
              end
              expect {
                client.wait_until(:output_string_array_any_property_matcher, input, max_wait_time: 2)
              }.to raise_error(max_wait_time_exceeded_error)
            end

            it 'fails when output property is null' do
              output_unexpected = {}
              2.times do
                allow(client).to receive(:get_widget).and_return(output_unexpected)
              end
              expect {
                client.wait_until(:output_string_array_any_property_matcher, input, max_wait_time: 2)
              }.to raise_error(max_wait_time_exceeded_error)
            end
          end

          context 'flatten' do
            it 'succeeds when match' do
              output = {
                children: [
                  {
                    grandchildren: [
                      {
                        name: 'expected name',
                        number: 1
                      }
                    ]
                  },
                  {
                    grandchildren: [
                      {
                        name: 'unexpected name',
                        number: 1
                      }
                    ]
                  }
                ]
              }
              expect(client).to receive(:get_widget).and_return(output)
              expect {
                client.wait_until(:flatten_matcher, input, max_wait_time: 60)
              }.to_not raise_error
            end

            it 'fails when no match' do
              output = {
                children: [
                  {
                    grandchildren: [
                      {
                        name: 'unexpected name',
                        number: 1
                      }
                    ]
                  }
                ]
              }
              2.times do
                allow(client).to receive(:get_widget).and_return(output)
              end
              expect {
                client.wait_until(:flatten_matcher, input, max_wait_time: 2)
              }.to raise_error(max_wait_time_exceeded_error)
            end
          end

          context 'flatten length' do
            it 'succeeds when match' do
              output = {
                children: [
                  {
                    grandchildren: [
                      {
                        name: 'name',
                        number: 1
                      },
                      {
                        name: 'name',
                        number: 2
                      },
                      {
                        name: 'name',
                        number: 3
                      }
                    ]
                  },
                  {
                    grandchildren: [
                      {
                        name: 'name',
                        number: 4
                      }
                    ]
                  },
                  {
                    grandchildren: [
                      {
                        name: 'name',
                        number: 5
                      },
                      {
                        name: 'name',
                        number: 6
                      }
                    ]
                  }
                ]
              }
              expect(client).to receive(:get_widget).and_return(output)
              expect {
                client.wait_until(:flatten_length_matcher, input, max_wait_time: 60)
              }.to_not raise_error
            end

            it 'fails when no match' do
              output = {
                children: [
                  {
                    grandchildren: [
                      {
                        name: 'name',
                        number: 1
                      }
                    ]
                  }
                ]
              }
              2.times do
                allow(client).to receive(:get_widget).and_return(output)
              end
              expect {
                client.wait_until(:flatten_length_matcher, input, max_wait_time: 2)
              }.to raise_error(max_wait_time_exceeded_error)
            end
          end

          context 'flatten filter' do
            it 'succeeds when match' do
              output = {
                children: [
                  {
                    grandchildren: [
                      {
                        name: 'name',
                        number: 1
                      },
                      {
                        name: 'name',
                        number: 2
                      },
                      {
                        name: 'name',
                        number: 3
                      }
                    ]
                  },
                  {
                    grandchildren: [
                      {
                        name: 'name',
                        number: 4
                      }
                    ]
                  },
                  {
                    grandchildren: [
                      {
                        name: 'name',
                        number: 5
                      },
                      {
                        name: 'name',
                        number: 6
                      }
                    ]
                  }
                ]
              }
              expect(client).to receive(:get_widget).and_return(output)
              expect {
                client.wait_until(:flatten_filter_matcher, input, max_wait_time: 60)
              }.to_not raise_error
            end

            it 'fails when no match' do
              output = {
                children: [
                  {
                    grandchildren: [
                      {
                        name: 'name',
                        number: 1
                      },
                      {
                        name: 'name',
                        number: 2
                      },
                      {
                        name: 'name',
                        number: 3
                      }
                    ]
                  },
                  {
                    grandchildren: [
                      {
                        name: 'name',
                        number: 4
                      },
                      {
                        name: 'name',
                        number: 5
                      },
                      {
                        name: 'name',
                        number: 6
                      }
                    ]
                  }
                ]
              }
              2.times do
                allow(client).to receive(:get_widget).and_return(output)
              end
              expect {
                client.wait_until(:flatten_filter_matcher, input, max_wait_time: 2)
              }.to raise_error(max_wait_time_exceeded_error)
            end
          end

          context 'length flatten filter' do
            it 'succeeds when match' do
              output = {
                children: [
                  {
                    grandchildren: [
                      {
                        name: 'name',
                        number: 1
                      },
                      {
                        name: 'name',
                        number: 2
                      },
                      {
                        name: 'name',
                        number: 3
                      }
                    ]
                  },
                  {
                    grandchildren: [
                      {
                        name: 'name',
                        number: 5
                      }
                    ]
                  },
                  {
                    grandchildren: [
                      {
                        name: 'name',
                        number: 6
                      },
                      {
                        name: 'name',
                        number: 7
                      }
                    ]
                  }
                ]
              }
              expect(client).to receive(:get_widget).and_return(output)
              expect {
                client.wait_until(:length_flatten_filter_matcher, input, max_wait_time: 60)
              }.to_not raise_error
            end

            it 'fails when no match' do
              output = {
                children: [
                  {
                    grandchildren: [
                      {
                        name: 'name',
                        number: 1
                      },
                      {
                        name: 'name',
                        number: 2
                      },
                      {
                        name: 'name',
                        number: 3
                      }
                    ]
                  },
                  {
                    grandchildren: [
                      {
                        name: 'name',
                        number: 3
                      },
                      {
                        name: 'name',
                        number: 4
                      },
                      {
                        name: 'name',
                        number: 5
                      }
                    ]
                  }
                ]
              }
              2.times do
                allow(client).to receive(:get_widget).and_return(output)
              end
              expect {
                client.wait_until(:length_flatten_filter_matcher, input, max_wait_time: 2)
              }.to raise_error(max_wait_time_exceeded_error)
            end
          end

          context 'projection' do
            it 'succeeds when match' do
              output = {
                data_map: {
                  'key1' => 'abc',
                  'key2' => 'abc',
                  'key3' => 'abc',
                }
              }
              expect(client).to receive(:get_widget).and_return(output)
              expect {
                client.wait_until(:projection_matcher, input, max_wait_time: 60)
              }.to_not raise_error
            end

            it 'fails when no match' do
              output = {
                data_map: {
                  'key1' => 'abc',
                  'key2' => 'def',
                  'key3' => 'ghi',
                }
              }
              2.times do
                allow(client).to receive(:get_widget).and_return(output)
              end
              expect {
                client.wait_until(:projection_matcher, input, max_wait_time: 2)
              }.to raise_error(max_wait_time_exceeded_error)
            end
          end

          context 'contains field' do
            it 'succeeds when match' do
              output = {
                string_property: 'match',
                data_map: {
                  'key1' => 'not a match',
                  'key2' => 'match',
                  'key3' => 'not a match',
                }
              }
              expect(client).to receive(:get_widget).and_return(output)
              expect {
                client.wait_until(:contains_field_matcher, input, max_wait_time: 60)
              }.to_not raise_error
            end

            it 'fails when no match' do
              output = {
                string_property: 'match',
                data_map: {
                  'key1' => 'not a match',
                  'key2' => 'not a match',
                  'key3' => 'not a match',
                }
              }
              2.times do
                allow(client).to receive(:get_widget).and_return(output)
              end
              expect {
                client.wait_until(:contains_field_matcher, input, max_wait_time: 2)
              }.to raise_error(max_wait_time_exceeded_error)
            end
          end

          context 'and inequality' do
            it 'succeeds when match' do
              output = {
                string_array_property: [
                  'some string',
                  'another string'
                ],
                data_map: {
                  'key1' => 'one',
                  'key2' => 'two',
                  'key3' => 'three',
                }
              }
              expect(client).to receive(:get_widget).and_return(output)
              expect {
                client.wait_until(:and_inequality_matcher, input, max_wait_time: 60)
              }.to_not raise_error
            end

            it 'fails when no match' do
              output = {
                string_array_property: [
                  'some string',
                  'another string',
                  'yet another string'
                ],
                data_map: {
                  'key1' => 'one',
                  'key2' => 'two',
                  'key3' => 'three',
                }
              }
              2.times do
                allow(client).to receive(:get_widget).and_return(output)
              end
              expect {
                client.wait_until(:and_inequality_matcher, input, max_wait_time: 2)
              }.to raise_error(max_wait_time_exceeded_error)
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

        it 'allows configuration of min and max delay' do
          options = {
            max_wait_time: 5,
            min_delay: 3,
            max_delay: 4
          }
          output = {}
          2.times do
            allow(client).to receive(:get_widget).and_return(output)
          end
          expect_any_instance_of(waiter).to receive(:delay).and_wrap_original do |m, *args|
            delay = m.call(*args)
            expect(delay).to equal(5)
            delay
          end
          expect {
            client.wait_until(:success_false_matcher, input, options)
          }.to raise_error(max_wait_time_exceeded_error)
        end

        it 'does not allow custom waiters' do
          custom_waiter = {
            'CustomWaiterMatcher' => {
              'acceptors' => [
                {
                  'state' => 'success',
                  'matcher' => {
                    'success' => true
                  }
                }
              ]
            }
          }
          client.config.service.operations[:delete_widget].traits['smithy.waiters#waitable'].merge!(custom_waiter)
          expect {
            client.wait_until(:custom_waiter_matcher, input, max_wait_time: 60)
          }.to raise_error(no_such_waiter_error)
        end

        it 'raises and error for nonexistent waiters' do
          expect {
            client.wait_until(:nonexistent_waiter, input, max_wait_time: 60)
          }.to raise_error(no_such_waiter_error)
        end

        it 'raises an error when max_wait_time is not provided' do
          expect {
            client.wait_until(:success_true_matcher, input)
          }.to raise_error(ArgumentError, 'Waiter must be initialized with `:max_wait_time`')
        end

        it 'raises an error when max_delay is less than 1' do
          options = {
            max_wait_time: 5,
            max_delay: 0
          }
          expect {
            client.wait_until(:success_true_matcher, input, options)
          }.to raise_error(ArgumentError, '`:max_delay` must be greater than 0')
        end

        it 'raises an error when min_delay is less than 1' do
          options = {
            max_wait_time: 5,
            min_delay: 0
          }
          expect {
            client.wait_until(:success_true_matcher, input, options)
          }.to raise_error(ArgumentError, '`:min_delay` must be greater than 0 and less than or equal to `:max_delay`')
        end

        it 'raises an error when max_delay is less than min_delay' do
          options = {
            max_wait_time: 5,
            min_delay: 4,
            max_delay: 2
          }
          expect {
            client.wait_until(:success_true_matcher, input, options)
          }.to raise_error(ArgumentError, '`:min_delay` must be greater than 0 and less than or equal to `:max_delay`')
        end
      end

      describe 'runtime generated waiters' do
        it 'allows custom waiters' do
          custom_waiter = {
            'CustomWaiterMatcher' => {
              'acceptors' => [
                {
                  'state' => 'success',
                  'matcher' => {
                    'success' => true
                  }
                }
              ]
            }
          }
          client.config.service.operations[:delete_widget].traits['smithy.waiters#waitable'].merge!(custom_waiter)
          output = {}
          expect(client).to receive(:delete_widget).and_return(output)
          expect {
            client.wait_until_custom(:custom_waiter_matcher, input, max_wait_time: 60)
          }.to_not raise_error
        end
      end
    end
  end
end