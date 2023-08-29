# frozen_string_literal: true

module Hearth
  module Middleware
    describe Initialize do
      let(:app) { double('app') }
      let(:input) { double('Type::OperationInput') }

      let(:request) { double('request') }
      let(:response) { double('response') }
      let(:interceptors) { double('interceptors', each: []) }
      let(:context) do
        Context.new(
          request: request,
          response: response,
          interceptors: interceptors
        )
      end

      subject { Initialize.new(app) }

      describe '#call' do
        context 'no errors' do
          it 'calls all of the interceptor hooks and the app' do
            expect(Interceptor).to receive(:apply)
              .with(hash_including(
                      hook: Interceptor::Hooks::READ_BEFORE_EXECUTION
                    )).ordered

            expect(app).to receive(:call).ordered

            expect(Interceptor).to receive(:apply)
              .with(hash_including(
                      hook: Interceptor::Hooks::MODIFY_BEFORE_COMPLETION
                    )).ordered
            expect(Interceptor).to receive(:apply)
              .with(hash_including(
                      hook: Interceptor::Hooks::READ_AFTER_EXECUTION
                    )).ordered

            subject.call(input, context)
          end
        end

        context 'read_before_execution error' do
          let(:interceptor_error) { StandardError.new }

          it 'calls all interceptor hooks but does not call the app' do
            expect(Interceptor).to receive(:apply)
              .with(hash_including(
                      hook: Interceptor::Hooks::READ_BEFORE_EXECUTION
                    ))
              .and_return(interceptor_error)

            expect(Interceptor).to receive(:apply)
              .with(hash_including(
                      hook: Interceptor::Hooks::MODIFY_BEFORE_COMPLETION
                    ))
            expect(Interceptor).to receive(:apply)
              .with(hash_including(
                      hook: Interceptor::Hooks::READ_AFTER_EXECUTION
                    ))
            expect(app).not_to receive(:call)

            output = subject.call(input, context)
            expect(output.error).to eq(interceptor_error)
          end
        end
      end
    end
  end
end
