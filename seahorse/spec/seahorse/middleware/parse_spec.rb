# frozen_string_literal: true

module Seahorse
  module Middleware
    describe Parse do
      let(:app) { double('app', call: output) }
      let(:error_parser) { double('error_parser') }
      let(:data_parser) { double('data_parser') }

      subject do
        Parse.new(
          app,
          error_parser: error_parser,
          data_parser: data_parser
        )
      end

      describe '#call' do
        let(:input) { double('input') }
        let(:output) { Output.new }
        let(:request) { double('request') }
        let(:response) { double('response') }
        let(:context) do
          Context.new(
            request: request,
            response: response
          )
        end

        it 'calls the next middleware then parses an error or data' do
          expect(app).to receive(:call)
            .with(input, context).ordered

          expect(error_parser).to receive(:parse).with(response).ordered
          expect(data_parser).to receive(:parse).with(response).ordered

          resp = subject.call(input, context)
          expect(resp).to be output
        end

        context 'response has an error' do
          let(:response) { double('response', status: 404) }
          let(:error) do
            Seahorse::ApiError.new(
              error_code: 'error_code',
              message: 'error'
            )
          end

          it 'parses the error' do
            expect(app).to receive(:call)
              .with(input, context).and_return(output).ordered
            expect(error_parser).to receive(:parse)
              .with(response).ordered.and_return(error)
            expect(data_parser).not_to receive(:parse)

            resp = subject.call(input, context)
            expect(resp).to be output
            expect(output.error).to eq error
          end
        end

        context 'response has data' do
          let(:data) { double('data') }

          it 'parses the data' do
            expect(app).to receive(:call)
              .with(input, context).ordered
            expect(error_parser).to receive(:parse).with(response).ordered
            expect(data_parser).to receive(:parse)
              .with(response).and_return(data)

            resp = subject.call(input, context)
            expect(resp).to be output
            expect(resp.data).to eq data
          end
        end
      end
    end
  end
end
