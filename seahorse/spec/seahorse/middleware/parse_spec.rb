# frozen_string_literal: true

require 'seahorse/middleware/parse'

module Seahorse
  module Middleware

    describe Parse do
      let(:app) { double('app') }
      let(:error_parser) { double('error_parser') }
      let(:data_parser) { double('data_parser') }
      let(:params) { { foo: 'bar' } }

      subject do
        Parse.new(
          app,
          error_parser: error_parser,
          data_parser: data_parser
        )
      end

      describe '#call' do
        let(:request) { Seahorse::HTTP::Request.new }
        let(:response) { Seahorse::HTTP::Response.new }
        let(:context) { {} }
        let(:output) { Seahorse::Output.new }

        it 'calls the next middleware then parses an error or data' do
          expect(app).to receive(:call).with(
            request: request,
            response: response,
            context: context
          ).and_return(output).ordered

          expect(error_parser).to receive(:parse)
            .with(response: response).ordered
          expect(data_parser).to receive(:parse)
            .with(response, output: output).ordered

          subject.call(
            request: request,
            response: response,
            context: context
          )
        end

        context 'response has an error' do
          let(:response) { Seahorse::HTTP::Response.new(status_code: 404) }
          let(:error) do
            Seahorse::ApiError.new(
              error_code: 'error_code',
              message: 'error'
            )
          end

          it 'parses the error' do
            expect(app).to receive(:call).with(
              request: request,
              response: response,
              context: context
            ).and_return(output).ordered
            expect(error_parser).to receive(:parse)
              .with(response: response).and_return(error).ordered
            expect(data_parser).not_to receive(:parse)

            output = subject.call(
              request: request,
              response: response,
              context: context
            )
            expect(output.error).to eq error
          end
        end

        context 'response has data' do
          let(:data) { double('data') }

          it 'parses the data' do
            expect(app).to receive(:call).with(
              request: request,
              response: response,
              context: context
            ).and_return(output).ordered
            expect(error_parser).to receive(:parse)
              .with(response: response).ordered
            expect(data_parser).to receive(:parse) { output.data = data }

            output = subject.call(
              request: request,
              response: response,
              context: context
            )
            expect(output.data).to eq data
          end
        end
      end
    end

  end
end
