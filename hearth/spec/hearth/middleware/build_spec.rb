# frozen_string_literal: true

module Hearth
  module Middleware
    describe Build do
      let(:app) { double('app', call: output) }
      let(:builder) { double('builder') }

      subject do
        Build.new(
          app,
          builder: builder
        )
      end

      describe '#call' do
        let(:input) { double('input') }
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

        it 'builds then calls the next middleware' do
          expect(builder).to receive(:build)
            .with(request, input: input).ordered
          expect(app).to receive(:call)
            .with(input, context).ordered

          out = subject.call(input, context)
          expect(out).to be output
        end

        it 'calls all of the interceptor hooks and the app' do
          expect(Interceptor).to receive(:apply)
            .with(hash_including(
                    hook: Interceptor::Hooks::MODIFY_BEFORE_SERIALIZATION
                  )).ordered
          expect(Interceptor).to receive(:apply)
            .with(hash_including(
                    hook: Interceptor::Hooks::READ_BEFORE_SERIALIZATION
                  )).ordered
          expect(builder).to receive(:build).ordered
          expect(Interceptor).to receive(:apply)
            .with(hash_including(
                    hook: Interceptor::Hooks::READ_AFTER_SERIALIZATION
                  )).ordered
          expect(app).to receive(:call).ordered
          subject.call(input, context)
        end

        context 'modify_before_serialization error' do
          let(:interceptor_error) { StandardError.new }

          it 'returns output with the error and skips build' do
            expect(Interceptor).to receive(:apply)
              .with(hash_including(
                      hook: Interceptor::Hooks::MODIFY_BEFORE_SERIALIZATION
                    ))
              .and_return(interceptor_error)

            expect(builder).not_to receive(:build)
            expect(app).not_to receive(:call)

            out = subject.call(input, context)
            expect(out.error).to eq(interceptor_error)
          end
        end

        context 'read_before_serialization error' do
          let(:interceptor_error) { StandardError.new }

          it 'returns output with the error and skips build' do
            expect(Interceptor).to receive(:apply)
              .with(hash_including(
                      hook: Interceptor::Hooks::MODIFY_BEFORE_SERIALIZATION
                    ))
            expect(Interceptor).to receive(:apply)
              .with(hash_including(
                      hook: Interceptor::Hooks::READ_BEFORE_SERIALIZATION
                    ))
              .and_return(interceptor_error)
            expect(builder).not_to receive(:build)
            expect(app).not_to receive(:call)

            out = subject.call(input, context)
            expect(out.error).to eq(interceptor_error)
          end
        end

        context 'read_after_serialization error' do
          let(:interceptor_error) { StandardError.new }

          it 'returns output with the error and skips the app' do
            expect(Interceptor).to receive(:apply)
              .with(hash_including(
                      hook: Interceptor::Hooks::MODIFY_BEFORE_SERIALIZATION
                    ))
            expect(Interceptor).to receive(:apply)
              .with(hash_including(
                      hook: Interceptor::Hooks::READ_BEFORE_SERIALIZATION
                    ))
            expect(builder).to receive(:build)
            expect(Interceptor).to receive(:apply)
              .with(hash_including(
                      hook: Interceptor::Hooks::READ_AFTER_SERIALIZATION
                    ))
              .and_return(interceptor_error)
            expect(app).not_to receive(:call)

            out = subject.call(input, context)
            expect(out.error).to eq(interceptor_error)
          end
        end
      end
    end
  end
end
