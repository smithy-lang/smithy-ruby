# frozen_string_literal: true

module Hearth
  module HTTP
    module TestErrors
      def self.error_code(_http_resp)
        nil
      end

      class ApiError < Hearth::ApiError; end

      class ApiRedirectError < ApiError
        def initialize(location:, **kwargs)
          @location = location
          super(**kwargs)
        end

        attr_reader :location
      end

      class ApiClientError < ApiError; end

      class ApiServerError < ApiError; end

      class ModeledError < ApiClientError; end

      module Parsers
        class ModeledError
          def self.parse(_http_resp, **_kwargs)
            TestErrors::ModeledError.new(error_code: 'ModeledError')
          end
        end
      end
    end

    describe ErrorParser do
      let(:error_module) { TestErrors }
      let(:success_status) { 200 }
      let(:error_parsers) { [TestErrors::Parsers::ModeledError] }

      let(:resp_status) { 200 }
      let(:fields) { Fields.new }
      let(:http_resp) { Response.new(status: resp_status, fields: fields) }
      let(:metadata) { { key: 'value' } }

      subject do
        Hearth::HTTP::ErrorParser.new(
          error_module: error_module,
          success_status: success_status,
          error_parsers: error_parsers
        )
      end

      describe '#parse' do
        context 'no error code' do
          context 'successful response: non-2XX success code matches' do
            let(:success_status) { 303 }
            let(:resp_status) { success_status }
            it 'does not return an error' do
              error = subject.parse(http_resp, metadata)
              expect(error).to be_nil
            end
          end

          context 'successful response: 2XX code, no success_status' do
            let(:resp_status) { 201 }
            it 'does not return an error' do
              error = subject.parse(http_resp, metadata)
              expect(error).to be_nil
            end
          end

          context 'error response: 3XX code' do
            let(:field) { Field.new('Location', 'http://example.com') }
            let(:fields) { Fields.new([field]) }

            let(:resp_status) { 300 }
            it 'returns an APIRedirectError' do
              error = subject.parse(http_resp, metadata)
              expect(error).to be_a(TestErrors::ApiRedirectError)
            end

            it 'populates a location' do
              error = subject.parse(http_resp, metadata)
              expect(error.location).to eq('http://example.com')
            end
          end

          context 'error response: 4XX code' do
            let(:resp_status) { 400 }
            it 'returns an APIClientError' do
              error = subject.parse(http_resp, metadata)
              expect(error).to be_a(TestErrors::ApiClientError)
            end
          end

          context 'error response: 5XX code' do
            let(:resp_status) { 500 }
            it 'returns an APIServerError' do
              error = subject.parse(http_resp, metadata)
              expect(error).to be_a(TestErrors::ApiServerError)
            end
          end
        end

        context 'error code on response' do
          before do
            expect(TestErrors).to receive(:error_code)
              .with(http_resp).and_return('ModeledError')
          end

          context 'error response: 2XX with error code' do
            let(:resp_status) { 200 }

            it 'returns the modeled error' do
              error = subject.parse(http_resp, metadata)
              expect(error).to be_a(TestErrors::ModeledError)
            end

            context 'Modeled error not in errors' do
              let(:errors) { [] }

              it 'returns the generic APIError' do
                error = subject.parse(http_resp, metadata)
                expect(error).to be_a(TestErrors::ApiError)
              end
            end
          end

          context 'error response: 4XX with error code' do
            let(:resp_status) { 400 }

            it 'returns the modeled error' do
              error = subject.parse(http_resp, metadata)
              expect(error).to be_a(TestErrors::ModeledError)
            end
          end
        end
      end
    end
  end
end
