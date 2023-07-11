# frozen_string_literal: true

module Hearth
  module Middleware
    describe Initialize do
      let(:app) { double('app') }
      let(:input) { double('Type::OperationInput') }
      let(:interceptors) { double('interceptors') }
      let(:context) { double('context', interceptors: interceptors) }

      subject { Initialize.new(app) }

      describe '#call' do
        context 'no errors' do
          it 'calls all of the interceptor hooks and the app' do
            expect(interceptors).to receive(:apply)
              .with(hash_including(
                      hook: Interceptor::Hooks::READ_BEFORE_EXECUTION
                    ))
            expect(interceptors).to receive(:apply)
              .with(hash_including(
                      hook: Interceptor::Hooks::MODIFY_BEFORE_COMPLETION
                    ))
            expect(interceptors).to receive(:apply)
              .with(hash_including(
                      hook: Interceptor::Hooks::READ_AFTER_EXECUTION
                    ))
            expect(app).to receive(:call)

            subject.call(input, context)
          end
        end

        context 'read_before_execution error' do
          let(:error) { StandardError.new }
          it 'calls all interceptor hooks but does not call the app' do
            expect(interceptors).to receive(:apply)
              .with(hash_including(
                      hook: Interceptor::Hooks::READ_BEFORE_EXECUTION
                    ))
              .and_return(error)

            expect(interceptors).to receive(:apply)
              .with(hash_including(
                      hook: Interceptor::Hooks::MODIFY_BEFORE_COMPLETION
                    ))
            expect(interceptors).to receive(:apply)
              .with(hash_including(
                      hook: Interceptor::Hooks::READ_AFTER_EXECUTION
                    ))
            expect(app).not_to receive(:call)

            output = subject.call(input, context)
            expect(output.error).to eq(error)
          end
        end
      end
    end
  end
end
