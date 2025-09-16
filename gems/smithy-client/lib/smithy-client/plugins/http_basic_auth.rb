# frozen_string_literal: true

require 'base64'

require_relative '../login'
require_relative '../login_provider'

module Smithy
  module Client
    module Plugins
      # @api private
      class HttpBasicAuth < Plugin
        option(
          :login_username,
          doc_type: String,
          docstring: 'The username to use for authentication.'
        ) do |config|
          'stubbed-username' if config.stub_responses
        end

        option(
          :login_password,
          doc_type: String,
          docstring: 'The password to use for authentication.'
        ) do |config|
          'stubbed-password' if config.stub_responses
        end

        option(
          :login_provider,
          doc_type: Smithy::Client::LoginProvider,
          docstring: <<~DOCS) do |config|
            A login identity provider. This can be an instance of a {Smithy::Client::LoginProvider} or any
            class that responds to #identity and returns a {Smithy::Client::Login}.
          DOCS
          provider = LoginProvider.new(username: config.login_username, password: config.login_password)
          provider if provider.set?
        end

        def after_initialize(client)
          client.config.auth_schemes['smithy.api#httpBasicAuth'] = client.config.login_provider
        end

        # @api private
        class Handler < Client::Handler
          def call(context)
            sign(context) if context.auth[:scheme_id] == 'smithy.api#httpBasicAuth'
            @handler.call(context)
          end

          private

          def sign(context)
            http_request = context.http_request
            identity = context.auth[:identity]

            http_request.headers.delete('Authorization')
            # TODO: does not handle realm or other properties
            identity_string = "#{identity.username}:#{identity.password}"
            encoded = Base64.strict_encode64(identity_string)
            http_request.headers['Authorization'] = "Basic #{encoded}"
          end
        end

        handler(Handler, step: :sign)
      end
    end
  end
end
