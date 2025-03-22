# frozen_string_literal: true

module Smithy
  module Client
    module Plugins
      # @api private
      class SignRequests < Plugin
        option(:anonymous_auth_scheme) do |_config|
          Smithy::Client::AuthSchemes::Anonymous.new
        end

        # @api private
        class Handler < Client::Handler
          def call(context)
            context[:auth].signer.sign(
              request: context.request,
              identity: context[:auth].identity,
              properties: context[:auth].signer_properties
            )
            @handler.call(context)
          end
        end

        handler(Handler, step: :sign)
      end
    end
  end
end
