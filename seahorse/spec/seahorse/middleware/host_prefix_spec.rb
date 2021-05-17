# frozen_string_literal: true

require 'seahorse/middleware/endpoint'

module Seahorse
  module Middleware

    describe HostPrefix do
      let(:app) { double('app') }
      let(:disable_host_prefix) { false }
      let(:host_prefix) { 'foo.' }
      let(:params) { {} }

      subject do
        HostPrefix.new(
          app,
          disable_host_prefix: disable_host_prefix,
          host_prefix: host_prefix,
          params: params
        )
      end

      describe '#call' do
        let(:url) { 'https://example.com' }
        let(:request) { Seahorse::HTTP::Request.new(url: url) }
        let(:response) { Seahorse::HTTP::Response.new }
        let(:context) { {} }

        it 'prefixes the host then calls the next middleware' do
          expect(request).to receive(:prefix_host)
            .with(host_prefix).ordered.and_call_original
          expect(app).to receive(:call).with(
            request: request,
            response: response,
            context: context
          ).ordered

          subject.call(
            request: request,
            response: response,
            context: context
          )

          expect(request.url).to eq('https://foo.example.com')
        end

        context 'disable_host_prefix is true' do
          let(:disable_host_prefix) { true }

          it 'does not prefix the host' do
            expect(app).to receive(:call).with(
              request: request,
              response: response,
              context: context
            )

            subject.call(
              request: request,
              response: response,
              context: context
            )

            expect(request.url).to eq(url)
          end
        end

        context 'host prefix has labels' do
          let(:host_prefix) { '{foo}.' }
          let(:params) { { foo: 'bar' } }

          it 'populates the label with params' do
            expect(app).to receive(:call).with(
              request: request,
              response: response,
              context: context
            )

            subject.call(
              request: request,
              response: response,
              context: context
            )

            expect(request.url).to eq('https://bar.example.com')
          end

          context 'params does not have the label' do
            let(:params) { {} }

            it 'raises an ArgumentError' do
              expect do
                subject.call(
                  request: request,
                  response: response,
                  context: context
                )
              end.to raise_error(ArgumentError)
            end
          end

          context 'params has an empty label' do
            let(:params) { { foo: '' } }

            it 'raises an ArgumentError' do
              expect do
                subject.call(
                  request: request,
                  response: response,
                  context: context
                )
              end.to raise_error(ArgumentError)
            end
          end
        end
      end
    end

  end
end
