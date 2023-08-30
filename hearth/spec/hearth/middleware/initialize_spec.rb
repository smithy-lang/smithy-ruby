# frozen_string_literal: true

module Hearth
  module Middleware
    describe Initialize do
      let(:app) { double('app', call: output) }
      let(:input) { double('Type::OperationInput') }
      let(:output) { Hearth::Output.new }
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
                    )).and_return(interceptor_error)

            expect(app).not_to receive(:call)

            expect(Interceptor).to receive(:apply)
              .with(hash_including(
                      hook: Interceptor::Hooks::MODIFY_BEFORE_COMPLETION
                    ))
            expect(Interceptor).to receive(:apply)
              .with(hash_including(
                      hook: Interceptor::Hooks::READ_AFTER_EXECUTION
                    ))

            out = subject.call(input, context)
            expect(out.error).to eq(interceptor_error)
          end
        end

        context 'modify_before_completion error' do
          let(:interceptor_error) { StandardError.new }

          it 'calls all interceptor hooks and app without replacing output' do
            expect(Interceptor).to receive(:apply)
              .with(hash_including(
                      hook: Interceptor::Hooks::READ_BEFORE_EXECUTION
                    ))

            expect(app).to receive(:call)

            expect(Interceptor).to receive(:apply)
              .with(hash_including(
                      hook: Interceptor::Hooks::MODIFY_BEFORE_COMPLETION
                    )).and_return(interceptor_error)
            expect(Interceptor).to receive(:apply)
              .with(hash_including(
                      hook: Interceptor::Hooks::READ_AFTER_EXECUTION
                    ))

            out = subject.call(input, context)
            expect(out).to be output
          end
        end

        context 'read_after_execution error' do
          let(:interceptor_error) { StandardError.new }

          it 'calls all interceptor hooks and app without replacing output' do
            expect(Interceptor).to receive(:apply)
              .with(hash_including(
                      hook: Interceptor::Hooks::READ_BEFORE_EXECUTION
                    ))

            expect(app).to receive(:call)

            expect(Interceptor).to receive(:apply)
              .with(hash_including(
                      hook: Interceptor::Hooks::MODIFY_BEFORE_COMPLETION
                    ))
            expect(Interceptor).to receive(:apply)
              .with(hash_including(
                      hook: Interceptor::Hooks::READ_AFTER_EXECUTION
                    )).and_return(interceptor_error)

            out = subject.call(input, context)
            expect(out).to be output
          end
        end
      end
    end
  end
end
