# frozen_string_literal: true

module Smithy
  module Client
    module Plugins
      # @api private
      class SignRequests < Plugin
        # @api private
        class Handler < Client::Handler
          def call(context)
            # TODO: AWS specific - put this in properties
            context[:auth].signer_properties['region'] = 'us-west-2'
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
