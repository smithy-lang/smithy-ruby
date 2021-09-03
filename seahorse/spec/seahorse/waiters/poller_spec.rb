# frozen_string_literal: true

module Seahorse
  module Waiters
    describe Poller do
      subject do
        Poller.new(
          operation_name: :test_operation,
          acceptors: acceptors
        )
      end

      let(:client) { double('client') }
      let(:input_output_middleware) { double('input_output_middleware') }

      let(:test_operation_struct) do
        Struct.new(
          :string,
          :boolean,
          :all_string,
          :any_string,
          keyword_init: true
        )
      end
      let(:response) do
        test_operation_struct.new(
          string: 'peccy',
          boolean: true,
          all_string: %w[foo foo],
          any_string: %w[bar foo]
        )
      end

      let(:error) do
        Seahorse::ApiError.new(
          error_code: 'SomeError',
          message: 'error'
        )
      end

      before do
        expect(Seahorse::MiddlewareBuilder).to receive(:before_send)
          .and_return(input_output_middleware)
      end

      describe '#call' do
        context 'no matchers' do
          let(:acceptors) { [] }

          context 'client error' do
            it 'returns error state with error' do
              expect(client).to receive(:test_operation)
                .with({}, { middleware: input_output_middleware })
                .and_raise(error)

              expect(subject.call(client, {}, {})).to eq [:error, error]
            end
          end

          context 'client response' do
            it 'returns retry state with response' do
              expect(client).to receive(:test_operation)
                .with({}, { middleware: input_output_middleware })
                .and_return(response)

              expect(subject.call(client, {}, {})).to eq [:retry, response]
            end
          end
        end

        context 'success matchers' do
          let(:acceptors) do
            [
              { state: 'success', matcher: { success: true } }
            ]
          end

          it 'can match success' do
            expect(client).to receive(:test_operation)
              .with({}, { middleware: input_output_middleware })
              .and_return(response)

            expect(subject.call(client, {}, {})).to eq [:success, response]
          end
        end

        context 'error type matchers' do
          let(:acceptors) do
            [
              { state: 'retry', matcher: { errorType: 'SomeError' } }
            ]
          end

          it 'can match error types' do
            expect(client).to receive(:test_operation)
              .with({}, { middleware: input_output_middleware })
              .and_raise(error)

            expect(subject.call(client, {}, {})).to eq [:retry, error]
          end
        end

        context 'input output matchers' do
          before do
            # Normally, middleware would capture input and store it on @input.
            # Since we are mocking middleware, pretend it was set to a structure
            # similar to our response test struct.
            subject.instance_variable_set(:@input, response)
          end

          context 'string equals' do
            let(:acceptors) do
              [
                {
                  state: 'success',
                  matcher: {
                    inputOutput: {
                      path: 'input.string',
                      expected: 'peccy',
                      comparator: 'stringEquals'
                    }
                  }
                }
              ]
            end

            it 'can match string equals' do
              expect(client).to receive(:test_operation)
                .with({}, { middleware: input_output_middleware })
                .and_return(response)

              expect(subject.call(client, {}, {})).to eq [:success, response]
            end
          end

          context 'boolean equals' do
            let(:acceptors) do
              [
                {
                  state: 'success',
                  matcher: {
                    inputOutput: {
                      path: 'length(input.string) == length(output.string)',
                      expected: 'true',
                      comparator: 'booleanEquals'
                    }
                  }
                }
              ]
            end

            it 'can match boolean equals' do
              expect(client).to receive(:test_operation)
                .with({}, { middleware: input_output_middleware })
                .and_return(response)

              expect(subject.call(client, {}, {})).to eq [:success, response]
            end
          end

          context 'all string equals' do
            let(:acceptors) do
              [
                {
                  state: 'success',
                  matcher: {
                    inputOutput: {
                      path: 'input.all_string',
                      expected: 'foo',
                      comparator: 'allStringEquals'
                    }
                  }
                }
              ]
            end

            it 'can match boolean equals' do
              expect(client).to receive(:test_operation)
                .with({}, { middleware: input_output_middleware })
                .and_return(response)

              expect(subject.call(client, {}, {})).to eq [:success, response]
            end
          end

          context 'any string equals' do
            let(:acceptors) do
              [
                {
                  state: 'success',
                  matcher: {
                    inputOutput: {
                      path: 'input.any_string',
                      expected: 'bar',
                      comparator: 'anyStringEquals'
                    }
                  }
                }
              ]
            end

            it 'can match boolean equals' do
              expect(client).to receive(:test_operation)
                .with({}, { middleware: input_output_middleware })
                .and_return(response)

              expect(subject.call(client, {}, {})).to eq [:success, response]
            end
          end
        end

        context 'output matchers' do
          context 'string equals' do
            let(:acceptors) do
              [
                {
                  state: 'success',
                  matcher: {
                    output: {
                      path: 'string',
                      expected: 'peccy',
                      comparator: 'stringEquals'
                    }
                  }
                }
              ]
            end

            it 'can match string equals' do
              expect(client).to receive(:test_operation)
                .with({}, { middleware: input_output_middleware })
                .and_return(response)

              expect(subject.call(client, {}, {})).to eq [:success, response]
            end
          end

          context 'boolean equals' do
            let(:acceptors) do
              [
                {
                  state: 'success',
                  matcher: {
                    output: {
                      path: 'boolean',
                      expected: 'true',
                      comparator: 'booleanEquals'
                    }
                  }
                }
              ]
            end

            it 'can match boolean equals' do
              expect(client).to receive(:test_operation)
                .with({}, { middleware: input_output_middleware })
                .and_return(response)

              expect(subject.call(client, {}, {})).to eq [:success, response]
            end
          end

          context 'all string equals' do
            let(:acceptors) do
              [
                {
                  state: 'success',
                  matcher: {
                    output: {
                      path: 'all_string',
                      expected: 'foo',
                      comparator: 'allStringEquals'
                    }
                  }
                }
              ]
            end

            it 'can match boolean equals' do
              expect(client).to receive(:test_operation)
                .with({}, { middleware: input_output_middleware })
                .and_return(response)

              expect(subject.call(client, {}, {})).to eq [:success, response]
            end
          end

          context 'any string equals' do
            let(:acceptors) do
              [
                {
                  state: 'success',
                  matcher: {
                    output: {
                      path: 'any_string',
                      expected: 'bar',
                      comparator: 'anyStringEquals'
                    }
                  }
                }
              ]
            end

            it 'can match boolean equals' do
              expect(client).to receive(:test_operation)
                .with({}, { middleware: input_output_middleware })
                .and_return(response)

              expect(subject.call(client, {}, {})).to eq [:success, response]
            end
          end
        end

        context 'multiple matchers' do
          let(:acceptors) do
            [
              {
                state: 'failure',
                matcher: {
                  output: {
                    path: 'any_string',
                    expected: 'should not match',
                    comparator: 'anyStringEquals'
                  }
                }
              },
              {
                state: 'success',
                matcher: {
                  output: {
                    path: 'string',
                    expected: 'peccy',
                    comparator: 'stringEquals'
                  }
                }
              }
            ]
          end

          it 'iterates all matchers' do
            expect(client).to receive(:test_operation)
              .with({}, { middleware: input_output_middleware })
              .and_return(response)

            expect(subject.call(client, {}, {})).to eq [:success, response]
          end
        end
      end
    end
  end
end
