# frozen_string_literal: true

require_relative '../anonymous_provider'
require_relative '../identities/anonymous'

module Smithy
  module Client
    module Plugins
      # @api private
      class AnonymousAuth < Plugin
        option(:anonymous_provider) do |_config|
          AnonymousProvider.new
        end

        def before_initialize(_client_class, options)
          return if options[:auth_schemes]

          options[:default_auth_schemes] ||= {}
          options[:default_auth_schemes]['smithy.api#noAuth'] = :anonymous_provider
        end

        class Handler < Client::Handler
          def call(context)
            if context.auth[:scheme_id] == 'smithy.api#noAuth'
              sign(context)
            end
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
