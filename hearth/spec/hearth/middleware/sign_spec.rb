# frozen_string_literal: true

module Hearth
  module Middleware
    describe Build do
      let(:app) { double('app', call: output) }

      subject { Sign.new(app) }

      describe '#call' do
        let(:input) { double('input') }
        let(:output) { double('output') }
        let(:request) { double('request') }
        let(:response) { double('response') }
        let(:interceptors) { double('interceptors', apply: nil) }
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

          resp = subject.call(input, context)
          expect(resp).to be output
        end

        it 'calls before_signing interceptors before sign' do
          expect(interceptors).to receive(:apply)
            .with(hash_including(
                    hook: Interceptor::Hooks::MODIFY_BEFORE_SIGNING
                  )).ordered
          expect(interceptors).to receive(:apply)
            .with(hash_including(
                    hook: Interceptor::Hooks::READ_BEFORE_SIGNING
                  )).ordered
          expect(signer).to receive(:sign).ordered
          expect(app).to receive(:call).ordered

          subject.call(input, context)
        end

        context 'modify_before_signing error' do
          let(:error) { StandardError.new }

          it 'returns output with the error and skips signing' do
            expect(interceptors).to receive(:apply)
              .with(hash_including(
                      hook: Interceptor::Hooks::MODIFY_BEFORE_SIGNING
                    ))
              .and_return(error)

            expect(signer).not_to receive(:sign)
            expect(app).not_to receive(:call)

            resp = subject.call(input, context)

            expect(resp.error).to eq(error)
          end
        end

        context 'read_before_signing error' do
          let(:error) { StandardError.new }

          it 'returns output with the error and skips signing' do
            expect(interceptors).to receive(:apply)
              .with(hash_including(
                      hook: Interceptor::Hooks::READ_BEFORE_SIGNING
                    ))
              .and_return(error)

            expect(signer).not_to receive(:sign)
            expect(app).not_to receive(:call)

            resp = subject.call(input, context)

            expect(resp.error).to eq(error)
          end
        end
      end
    end
  end
end
