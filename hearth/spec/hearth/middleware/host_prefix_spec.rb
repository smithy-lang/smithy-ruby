# frozen_string_literal: true

module Hearth
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
        let(:struct) { Struct.new(:foo, keyword_init: true) }
        let(:input) { struct.new }

        let(:output) { double('output') }
        let(:uri) { URI('https://example.com') }
        let(:request) { Hearth::HTTP::Request.new(uri: uri) }
        let(:response) { double('response') }
        let(:context) do
          Context.new(
            request: request,
            response: response
          )
        end

        context 'disable_host_prefix is false' do
          let(:disable_host_prefix) { false }

          it 'prefixes the host then calls the next middleware' do
            expect(request).to receive(:prefix_host)
              .with(host_prefix).ordered.and_call_original
            expect(app).to receive(:call).with(input, context).ordered

            resp = subject.call(input, context)
            expect(request.uri.to_s).to eq('https://foo.example.com')
            expect(resp).to be output
          end

          context 'host prefix has labels' do
            let(:host_prefix) { '{foo}.' }
            let(:input) { struct.new(foo: 'bar') }

            it 'populates the label with input' do
              expect(app).to receive(:call).with(input, context)

              resp = subject.call(input, context)
              expect(request.uri.to_s).to eq('https://bar.example.com')
              expect(resp).to be output
            end

            context 'input does not have the label' do
              let(:input) { struct.new }

              it 'raises an ArgumentError' do
                expect do
                  subject.call(input, context)
                end.to raise_error(ArgumentError)
              end
            end

            context 'input has an empty label' do
              let(:input) { struct.new(foo: '') }

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
            expect(request.uri).to eq(uri)
            expect(resp).to be output
          end
        end
      end
    end
  end
end
