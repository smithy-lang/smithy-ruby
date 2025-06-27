# frozen_string_literal: true

require_relative '../http_login_provider'
require_relative '../identities/http_login'
require_relative 'resolve_auth'

module Smithy
  module Client
    module Plugins
      # @api private
      class HttpBasicAuth < Plugin
        option(
          :http_login_username,
          doc_type: String,
          docstring: 'The username to use for authentication.'
        ) do |config|
          'stubbed-username' if config.stub_responses
        end

        option(
          :http_login_password,
          doc_type: String,
          docstring: 'The password to use for authentication.'
        ) do |config|
          'stubbed-password' if config.stub_responses
        end

        option(
          :http_login_provider,
          doc_type: Smithy::Client::HttpLoginProvider,
          docstring: <<~DOCS) do |config|
            A login identity provider. This can be an instance of a {Smithy::Client::HttpLoginProvider} or any
            class that responds to #identity and returns a {Smithy::Client::Identities::HttpLogin}.
          DOCS
          if config.http_login_username && config.http_login_password
            Smithy::Client::HttpLoginProvider.new(config.http_login_username, config.http_login_password)
          end
        end

        def before_initialize(_client_class, options)
          ResolveAuth.add_auth_scheme('smithy.api#httpBasicAuth', :http_login_provider)
        end

        class Handler < Client::Handler
          def call(context)
            if context.auth[:scheme_id] == 'smithy.api#httpBasicAuth'
              sign(context)
            end
            @handler.call(context)
          end

          def sign(context)
            reset(context)
            # TODO: does not handle realm or other properties
            identity = context.auth[:identity]
            identity_string = "#{identity.username}:#{identity.password}"
            encoded = Base64.strict_encode64(identity_string)
            context.http_request.headers['Authorization'] = "Basic #{encoded}"
          end

          def reset(context)
            context.http_request.headers.delete('Authorization')
          end
        end

        handler(Handler, step: :sign)
      end
    end
  end
end
