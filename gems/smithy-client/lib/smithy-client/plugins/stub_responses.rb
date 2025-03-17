# frozen_string_literal: true

module Smithy
  module Client
    module Plugins
      # @api private
      class StubResponses < Plugin
        option(
          :stub_responses,
          default: false,
          doc_type: 'Boolean',
          docstring: <<~DOCS)
            When true, the client will return stubbed responses instead of networking requests.
            By default fake responses are generated and returned. You can specify the response data
            to return or errors to raise by calling {Stubs#stub_responses}.
            @see Stubs
          DOCS

        option(:stubs) { {} }
        # @api private
        option(:stubs_mutex) { Mutex.new }
        # @api private
        option(:api_requests) { [] }
        # @api private
        option(:api_requests_mutex) { Mutex.new }

        def add_handlers(handlers, config)
          return unless config.stub_responses

          handlers.add(APIRequestsHandler)
          handlers.add(StubHandler, step: :send)
        end

        def before_initialize(_client_class, options)
          return unless options[:stub_responses]

          options[:endpoint_provider] ||= Stubbing::EndpointProvider.new
        end

        def after_initialize(client)
          return unless client.config.stub_responses

          client.handlers.remove(RetryErrors::Handler)
        end

        # Returns a registered stubbed response instead of a real response.
        # @api private
        class StubHandler < Client::Handler
          def call(context)
            output = Smithy::Client::Output.new(context: context)
            stub = context.client.next_stub(context)
            stub[:mutex].synchronize { apply_stub(stub, output) }
            output
          end

          private

          def apply_stub(stub, output)
            resp = output.context.response
            if stub[:error]
              signal_error(stub[:error], resp)
            elsif stub[:http]
              signal_http(stub[:http], resp)
            end
          end

          def signal_error(error, resp)
            if error.is_a?(Exception)
              resp.signal_error(error)
            else
              resp.signal_error(error.new)
            end
          end

          def signal_http(stub, resp)
            resp.signal_headers(stub.status_code, stub.headers)
            signal_data(stub, resp)
            resp.signal_done
          end

          def signal_data(stub, resp)
            while (chunk = stub.body.read(1024 * 1024))
              resp.signal_data(chunk)
            end
            stub.body.rewind
          end
        end

        # Tracks API requests made by the client.
        # @api private
        class APIRequestsHandler < Client::Handler
          def call(context)
            context.config.api_requests_mutex.synchronize do
              context.config.api_requests << context
            end
            @handler.call(context)
          end
        end
      end
    end
  end
end
