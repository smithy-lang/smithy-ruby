# frozen_string_literal: true

module Hearth
  module Middleware
    describe Parse do
      let(:app) { double('app', call: output) }
      let(:input) { double('input') }
      let(:output) { Hearth::Output.new(metadata: metadata) }
      let(:error_parser) { double('error_parser') }
      let(:data_parser) { double('data_parser') }

      subject do
        Parse.new(app, error_parser: error_parser, data_parser: data_parser)
      end

      describe '#call' do
        let(:request) { double('request') }
        let(:response) { double('response') }
        let(:logger) { Logger.new(IO::NULL) }
        let(:interceptors) { double('interceptors', each: []) }
        let(:config) do
          double('config', logger: logger, interceptors: interceptors)
        end
        let(:context) do
          Context.new(request: request, response: response, config: config)
        end

        let(:metadata) { { key: 'value' } }

        it 'calls the next middleware then parses an error or data' do
          expect(app).to receive(:call).with(input, context).ordered

          expect(error_parser).to receive(:parse)
            .with(response, metadata)
            .ordered
          expect(data_parser).to receive(:parse).with(response).ordered

          out = subject.call(input, context)
          expect(out).to be output
        end

        it 'calls all of the interceptor hooks after the next middleware' do
          expect(app).to receive(:call).ordered
          expect(Interceptors).to receive(:invoke)
            .with(hash_including(
                    hook: Interceptor::MODIFY_BEFORE_DESERIALIZATION
                  )).ordered
          expect(Interceptors).to receive(:invoke)
            .with(hash_including(
                    hook: Interceptor::READ_BEFORE_DESERIALIZATION
                  )).ordered

          expect(error_parser).to receive(:parse).ordered
          expect(data_parser).to receive(:parse).ordered

          expect(Interceptors).to receive(:invoke)
            .with(hash_including(
                    hook: Interceptor::READ_AFTER_DESERIALIZATION
                  )).ordered

          subject.call(input, context)
        end

        context 'modify_before_deserialization error' do
          let(:interceptor_error) { StandardError.new }

          it 'returns output with the error set' do
            expect(app).to receive(:call).and_return(output)

            expect(Interceptors).to receive(:invoke)
              .with(hash_including(
                      hook: Interceptor::MODIFY_BEFORE_DESERIALIZATION
                    )).and_return(interceptor_error)

            expect(error_parser).not_to receive(:parse)
            expect(data_parser).not_to receive(:parse)

            out = subject.call(input, context)
            expect(out).to eq(output)
          end
        end

        context 'read_before_deserialization error' do
          let(:interceptor_error) { StandardError.new }

          it 'returns output with the error set' do
            expect(app).to receive(:call).and_return(output)

            expect(Interceptors).to receive(:invoke)
              .with(hash_including(
                      hook: Interceptor::MODIFY_BEFORE_DESERIALIZATION
                    ))
            expect(Interceptors).to receive(:invoke)
              .with(hash_including(
                      hook: Interceptor::READ_BEFORE_DESERIALIZATION
                    )).and_return(interceptor_error)

            expect(error_parser).not_to receive(:parse)
            expect(data_parser).not_to receive(:parse)

            out = subject.call(input, context)
            expect(out).to eq(output)
          end
        end

        context 'read_after_deserialization error' do
          let(:interceptor_error) { StandardError.new }

          it 'returns output with the error set' do
            expect(app).to receive(:call).and_return(output)

            expect(Interceptors).to receive(:invoke)
              .with(hash_including(
                      hook: Interceptor::MODIFY_BEFORE_DESERIALIZATION
                    ))
            expect(Interceptors).to receive(:invoke)
              .with(hash_including(
                      hook: Interceptor::READ_BEFORE_DESERIALIZATION
                    ))

            expect(error_parser).to receive(:parse)
            expect(data_parser).to receive(:parse)

            expect(Interceptors).to receive(:invoke)
              .with(hash_including(
                      hook: Interceptor::READ_AFTER_DESERIALIZATION
                    )).and_return(interceptor_error)

            out = subject.call(input, context)
            expect(out).to eq(output)
          end
        end

        context 'response has an error' do
          let(:response) { double('response', status: 404) }
          let(:error) do
            Hearth::ApiError.new(
              error_code: 'error_code',
              metadata: metadata,
              message: 'error'
            )
          end

          it 'parses the error' do
            expect(app).to receive(:call)
              .with(input, context)
              .and_return(output)
              .ordered
            expect(error_parser).to receive(:parse)
              .with(response, metadata)
              .ordered
              .and_return(error)
            expect(data_parser).not_to receive(:parse)

            out = subject.call(input, context)
            expect(out).to be output
            expect(output.error).to eq error
          end
        end

        context 'response has data' do
          let(:data) { double('data') }

          it 'parses the data' do
            expect(app).to receive(:call).with(input, context).ordered
            expect(error_parser).to receive(:parse)
              .with(response, metadata)
              .ordered
            expect(data_parser).to receive(:parse)
              .with(response)
              .and_return(data)

            out = subject.call(input, context)
            expect(out).to be output
            expect(out.data).to eq data
          end
        end
      end
    end
  end
end
