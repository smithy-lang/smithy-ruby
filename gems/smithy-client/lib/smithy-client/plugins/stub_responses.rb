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

        def add_handlers(handlers, config)
          handlers.add(Handler, step: :send) if config.stub_responses
        end

        def after_initialize(client)
          client.setup_stubbing if client.config.stub_responses
        end

        # @api private
        class Handler < Client::Handler
          def call(context)
            stub = context.client.next_stub(context)
            output = Smithy::Client::Output.new(context: context)
            
            if Hash === stub && stub[:mutex]
              stub[:mutex].synchronize { apply_stub(stub, output) }
            else
              apply_stub(stub, output)
            end

            output
          end

          private

          def apply_stub(stub, output)
            resp = output.context.response
            case
            when stub[:error] then signal_error(stub[:error], resp)
            when stub[:http] then signal_http(stub[:http], resp)
            when stub[:data] then signal_data(stub[:data], resp)
            end
          end

          def signal_error(error, http_resp)
            if error.is_a?(Exception)
              http_resp.signal_error(error)
            else
              http_resp.signal_error(error.new)
            end
          end

          def signal_http(stub, http_resp)
            http_resp.signal_headers(stub.status_code, stub.headers)
            signal_data(stub, http_resp)
            http_resp.signal_done
          end

          def signal_data(stub, http_resp)
            while (chunk = stub.body.read(1024 * 1024))
              http_resp.signal_data(chunk)
            end
            stub.body.rewind
          end
        end
      end
    end
  end
end

