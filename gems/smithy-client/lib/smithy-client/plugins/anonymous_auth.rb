# frozen_string_literal: true

require_relative '../anonymous_provider'
require_relative '../identities/anonymous'
require_relative 'resolve_auth'

module Smithy
  module Client
    module Plugins
      # @api private
      class AnonymousAuth < Plugin
        option(:anonymous_provider) do |_config|
          AnonymousProvider.new
        end

        def after_initialize(client)
          client.config.auth_schemes['smithy.api#noAuth'] = :anonymous_provider
        end

        # @api private
        class Handler < Client::Handler
          def call(context)
            sign(context) if context.auth[:scheme_id] == 'smithy.api#noAuth'
            @handler.call(context)
          end

          def sign(context); end
          def reset(context); end
        end

        handler(Handler, step: :sign)
      end
    end
  end
end
