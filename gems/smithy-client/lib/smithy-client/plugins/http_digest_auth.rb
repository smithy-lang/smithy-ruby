# frozen_string_literal: true

require_relative '../http_login_provider'
require_relative '../identities/http_login'

module Smithy
  module Client
    module Plugins
      # @api private
      class HttpDigestAuth < Plugin
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
          :http_login_identity,
          doc_type: Identities::HttpLogin,
          docstring: 'The login identity to use for authentication.'
        ) do |config|
          if config.http_login_username && config.http_login_password
            Identities::HttpLogin.new(
              username: config.http_login_username,
              password: config.http_login_password
            )
          end
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

        def after_initialize(client)
          client.config.auth_schemes['smithy.api#httpDigestAuth'] = client.config.http_login_provider
        end

        # @api private
        class Handler < Client::Handler
          def call(context)
            sign(context) if context.auth[:scheme_id] == 'smithy.api#httpDigestAuth'
            @handler.call(context)
          end

          def sign(_context)
            # TODO: requires a nonce from the server
            # This cannot be implemented unless we rescue from a 401 and retry with the nonce
            raise NotImplementedError
          end
        end

        handler(Handler, step: :sign)
      end
    end
  end
end
