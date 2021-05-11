require 'seahorse/http'

module Seahorse
  module HTTP

    module TestErrors
      class ApiError < Seahorse::HTTP::ApiError; end
      class ApiRedirectError < ApiError
        def initialize(location:, **kwargs)
          @location = location
          super(**kwargs)
        end
      end
      class ApiClientError < ApiError; end
      class ApiServerError < ApiError; end

      class TestModeledError < ApiClientError; end
    end

    describe ErrorParser do

      let(:error_module) { TestErrors }
      let(:success_status_code) { 200 }
      let(:errors) { [TestErrors::TestModeledError] }
      let(:error_code_fn) { proc { nil } }

      let(:resp_status_code) { 200 }
      let(:http_resp) { Response.new(status_code: resp_status_code) }


      subject do
        Seahorse::HTTP::ErrorParser.new(
          error_module: error_module,
          success_status_code: success_status_code,
          errors: errors,
          error_code_fn: error_code_fn
        )
      end

      describe '#parse' do
        context 'no error code' do
          let(:error_code_fn) { proc { nil } }

          context 'successful response: non-2XX success code matches' do
            let(:success_status_code) { 303 }
            let(:resp_status_code) { success_status_code }
            it 'does not return an error' do
              error = subject.parse(http_resp)
              expect(error).to be_nil
            end
          end

          context 'successful response: 2XX code, no success_status_code' do
            let(:resp_status_code) { 201 }
            it 'does not return an error' do
              error = subject.parse(http_resp)
              expect(error).to be_nil
            end
          end

          context 'error response: 3XX code' do
            let(:resp_status_code) { 300 }
            it 'returns an APIRedirectError' do
              error = subject.parse(http_resp)
              expect(error).to be_a(TestErrors::ApiRedirectError)
            end
          end

          context 'error response: 4XX code' do
            let(:resp_status_code) { 400 }
            it 'returns an APIClientError' do
              error = subject.parse(http_resp)
              expect(error).to be_a(TestErrors::ApiClientError)
            end
          end

          context 'error response: 5XX code' do
            let(:resp_status_code) { 500 }
            it 'returns an APIServerError' do
              error = subject.parse(http_resp)
              expect(error).to be_a(TestErrors::ApiServerError)
            end
          end
        end

        context 'error code on response' do
          let(:error_code_fn) { proc { 'TestModeledError' } }

          context 'error response: 2XX with error code' do
            let(:resp_status_code) { 200 }

            it 'returns the modeled error' do
              error = subject.parse(http_resp)
              expect(error).to be_a(TestErrors::TestModeledError)
            end

            context 'Modeled error not in errors' do
              let(:errors) { [] }

              it 'returns the generic APIError' do
                error = subject.parse(http_resp)
                expect(error).to be_a(TestErrors::ApiError)
              end
            end
          end

          context 'error response: 4XX with error code' do
            let(:resp_status_code) { 400 }

            it 'returns the modeled error' do
              error = subject.parse(http_resp)
              expect(error).to be_a(TestErrors::TestModeledError)
            end
          end
        end
      end
    end
  end
end
