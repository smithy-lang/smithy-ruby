# frozen_string_literal: true

module Hearth
  module Middleware
    describe Initialize do
      let(:app) { double('app', call: output) }
      let(:input) { double('input') }
      let(:output) { Hearth::Output.new }

      subject { Initialize.new(app) }

      describe '#call' do
        let(:request) { double('request') }
        let(:response) { double('response') }
        let(:logger) { Logger.new(IO::NULL) }
        let(:interceptors) { double('interceptors', each: []) }
        let(:context) do
          Context.new(
            request: request,
            response: response,
            logger: logger,
            interceptors: interceptors
          )
        end

        context 'no errors' do
          it 'calls all of the interceptor hooks and the app' do
            expect(Interceptors).to receive(:invoke)
              .with(hash_including(
                      hook: Interceptor::READ_BEFORE_EXECUTION
                    )).ordered

            expect(app).to receive(:call).ordered

            expect(Interceptors).to receive(:invoke)
              .with(hash_including(
                      hook: Interceptor::MODIFY_BEFORE_COMPLETION
                    )).ordered
            expect(Interceptors).to receive(:invoke)
              .with(hash_including(
                      hook: Interceptor::READ_AFTER_EXECUTION
                    )).ordered

            subject.call(input, context)
          end
        end

        context 'read_before_execution error' do
          let(:interceptor_error) { StandardError.new }

          it 'calls all interceptor hooks but does not call the app' do
            expect(Interceptors).to receive(:invoke)
              .with(hash_including(
                      hook: Interceptor::READ_BEFORE_EXECUTION
                    )).and_return(interceptor_error)

            expect(app).not_to receive(:call)

            expect(Interceptors).to receive(:invoke)
              .with(hash_including(
                      hook: Interceptor::MODIFY_BEFORE_COMPLETION
                    ))
            expect(Interceptors).to receive(:invoke)
              .with(hash_including(
                      hook: Interceptor::READ_AFTER_EXECUTION
                    ))

            out = subject.call(input, context)
            expect(out.error).to eq(interceptor_error)
          end
        end

        context 'modify_before_completion error' do
          let(:interceptor_error) { StandardError.new }

          it 'calls all interceptor hooks and app without replacing output' do
            expect(Interceptors).to receive(:invoke)
              .with(hash_including(
                      hook: Interceptor::READ_BEFORE_EXECUTION
                    ))

            expect(app).to receive(:call)

            expect(Interceptors).to receive(:invoke)
              .with(hash_including(
                      hook: Interceptor::MODIFY_BEFORE_COMPLETION
                    )).and_return(interceptor_error)
            expect(Interceptors).to receive(:invoke)
              .with(hash_including(
                      hook: Interceptor::READ_AFTER_EXECUTION
                    ))

            out = subject.call(input, context)
            expect(out).to be output
          end
        end

        context 'read_after_execution error' do
          let(:interceptor_error) { StandardError.new }

          it 'calls all interceptor hooks and app without replacing output' do
            expect(Interceptors).to receive(:invoke)
              .with(hash_including(
                      hook: Interceptor::READ_BEFORE_EXECUTION
                    ))

            expect(app).to receive(:call)

            expect(Interceptors).to receive(:invoke)
              .with(hash_including(
                      hook: Interceptor::MODIFY_BEFORE_COMPLETION
                    ))
            expect(Interceptors).to receive(:invoke)
              .with(hash_including(
                      hook: Interceptor::READ_AFTER_EXECUTION
                    )).and_return(interceptor_error)

            out = subject.call(input, context)
            expect(out).to be output
          end
        end
      end
    end
  end
end
