# frozen_string_literal: true

module Smithy
  module Client
    module Plugins
      # @api private
      class SignRequests < Plugin
        # @api private
        class Handler < Client::Handler
          def call(context)
            context.auth[:signer].sign(context)
            @handler.call(context)
          end
        end

        handler(Handler, step: :sign)
      end
    end
  end
end
