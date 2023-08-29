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
        let(:output) { double('output') }
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

          resp = subject.call(input, context)
          expect(resp).to be output
        end

        it 'calls before_serialization interceptors before build' do
          expect(Interceptor).to receive(:apply)
            .with(hash_including(
                    hook: Interceptor::Hooks::MODIFY_BEFORE_SERIALIZATION
                  )).ordered
          expect(Interceptor).to receive(:apply)
            .with(hash_including(
                    hook: Interceptor::Hooks::READ_BEFORE_SERIALIZATION
                  )).ordered
          expect(builder).to receive(:build).ordered
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

            resp = subject.call(input, context)

            expect(resp.error).to eq(interceptor_error)
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

            resp = subject.call(input, context)

            expect(resp.error).to eq(interceptor_error)
          end
        end
      end
    end
  end
end
