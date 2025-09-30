# frozen_string_literal: true

module Smithy
  module Client
    module Plugins
      # @api private
      class SignRequests < Plugin
        # @api private
        class Handler < Smithy::Client::Handler
          def call(context)
            signer = context.auth.signer
            signer.sign_request(context)
            @handler.call(context)
          end
        end

        handler(Handler, step: :sign)
      end
    end
  end
end
