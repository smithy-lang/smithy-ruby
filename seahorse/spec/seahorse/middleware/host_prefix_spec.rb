# frozen_string_literal: true

module Seahorse
  module Middleware

    describe HostPrefix do
      let(:app) { double('app', call: output) }
      let(:host_prefix) { 'foo.' }

      subject do
        HostPrefix.new(
          app,
          disable_host_prefix: disable_host_prefix,
          host_prefix: host_prefix
        )
      end

      describe '#call' do
        let(:input) { double('input') }
        let(:output) { double('output') }
        let(:url) { 'https://example.com' }
        let(:request) { Seahorse::HTTP::Request.new(url: url) }
        let(:response) { double('response') }
        let(:params) { {} }
        let(:context) do
          Context.new(
            request: request,
            response: response,
            params: params
          )
        end

        context 'disable_host_prefix is false' do
          let(:disable_host_prefix) { false }

          it 'prefixes the host then calls the next middleware' do
            expect(request).to receive(:prefix_host)
              .with(host_prefix).ordered.and_call_original
            expect(app).to receive(:call).with(input, context).ordered

            resp = subject.call(input, context)
            expect(request.url).to eq('https://foo.example.com')
            expect(resp).to be output
          end

          context 'host prefix has labels' do
            let(:host_prefix) { '{foo}.' }
            let(:params) { { foo: 'bar' } }

            it 'populates the label with params' do
              expect(app).to receive(:call).with(input, context)

              resp = subject.call(input, context)
              expect(request.url).to eq('https://bar.example.com')
              expect(resp).to be output
            end

            context 'params does not have the label' do
              let(:params) { {} }

              it 'raises an ArgumentError' do
                expect do
                  subject.call(input, context)
                end.to raise_error(ArgumentError)
              end
            end

            context 'params has an empty label' do
              let(:params) { { foo: '' } }

              it 'raises an ArgumentError' do
                expect do
                  subject.call(input, context)
                end.to raise_error(ArgumentError)
              end
            end
          end
        end

        context 'disable_host_prefix is true' do
          let(:disable_host_prefix) { true }

          it 'does not prefix the host and calls the next middleware' do
            expect(app).to receive(:call).with(input, context)

            resp = subject.call(input, context)
            expect(request.url).to eq(url)
            expect(resp).to be output
          end
        end
      end
    end

  end
end
