# frozen_string_literal: true

module Smithy
  module Client
    module Plugins
      # @api private
      class SignRequests < Plugin
        option(:auth_schemes, docstring: 'todo') { [] }

        option(:auth_resolver, docstring: 'todo')

        # @api private
        class Handler < Client::Handler
          def call(context)
            require 'byebug'
            byebug
            @handler.call(context)
          end
        end

        handler(Handler, step: :sign)
      end
    end
  end
end
