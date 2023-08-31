# frozen_string_literal: true

module Hearth
  module Middleware
    describe Build do
      let(:app) { double('app', call: output) }

      subject { Sign.new(app) }

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

        let(:signer) { double('signer', sign: nil) }
        let(:identity) { double('identity') }
        let(:auth_option) do
          double(
            'auth_option',
            signer_properties: {},
            identity_properties: {}
          )
        end
        let(:resolved_auth) do
          double(
            'resolved_auth',
            signer: signer,
            signer_properties: auth_option.signer_properties,
            identity: identity,
            identity_properties: auth_option.identity_properties
          )
        end

        before { context.auth = resolved_auth }

        it 'signs then calls the next middleware' do
          expect(signer).to receive(:sign)
            .with(request: request, identity: identity, properties: {})
            .ordered
          expect(app).to receive(:call).with(input, context).ordered

          out = subject.call(input, context)
          expect(out).to be output
        end

        it 'calls all of the interceptor hooks and the app' do
          expect(Interceptors).to receive(:invoke)
            .with(hash_including(
                    hook: Interceptor::MODIFY_BEFORE_SIGNING
                  )).ordered
          expect(Interceptors).to receive(:invoke)
            .with(hash_including(
                    hook: Interceptor::READ_BEFORE_SIGNING
                  )).ordered
          expect(signer).to receive(:sign).ordered
          expect(app).to receive(:call).ordered

          expect(Interceptors).to receive(:invoke)
            .with(hash_including(
                    hook: Interceptor::READ_AFTER_SIGNING
                  )).ordered

          subject.call(input, context)
        end

        context 'modify_before_signing error' do
          let(:interceptor_error) { StandardError.new }

          it 'returns output with the error and skips signing' do
            expect(Interceptors).to receive(:invoke)
              .with(hash_including(
                      hook: Interceptor::MODIFY_BEFORE_SIGNING
                    )).and_return(interceptor_error)

            expect(signer).not_to receive(:sign)
            expect(app).not_to receive(:call)

            out = subject.call(input, context)
            expect(out.error).to eq(interceptor_error)
          end
        end

        context 'read_before_signing error' do
          let(:interceptor_error) { StandardError.new }

          it 'returns output with the error and skips signing' do
            expect(Interceptors).to receive(:invoke)
              .with(hash_including(
                      hook: Interceptor::MODIFY_BEFORE_SIGNING
                    ))
            expect(Interceptors).to receive(:invoke)
              .with(hash_including(
                      hook: Interceptor::READ_BEFORE_SIGNING
                    )).and_return(interceptor_error)

            expect(signer).not_to receive(:sign)
            expect(app).not_to receive(:call)

            out = subject.call(input, context)
            expect(out.error).to eq(interceptor_error)
          end
        end

        context 'read_after_signing error' do
          let(:interceptor_error) { StandardError.new }

          it 'returns output with the error and skips signing' do
            expect(Interceptors).to receive(:invoke)
              .with(hash_including(
                      hook: Interceptor::MODIFY_BEFORE_SIGNING
                    ))
            expect(Interceptors).to receive(:invoke)
              .with(hash_including(
                      hook: Interceptor::READ_BEFORE_SIGNING
                    ))

            expect(signer).to receive(:sign)
            expect(app).to receive(:call)

            expect(Interceptors).to receive(:invoke)
              .with(hash_including(
                      hook: Interceptor::READ_AFTER_SIGNING
                    )).and_return(interceptor_error)

            out = subject.call(input, context)
            expect(out).to eq(output)
          end
        end
      end
    end
  end
end
