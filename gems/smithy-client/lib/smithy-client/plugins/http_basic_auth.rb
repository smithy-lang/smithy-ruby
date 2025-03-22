# frozen_string_literal: true

require 'smithy-client/auth_schemes/http_basic'

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
          :http_login_identity_provider,
          doc_type: Smithy::Client::IdentityProvider,
          docstring: <<~DOCS) do |config|
            A login identity provider. This can be an instance of a {Smithy::Client::IdentityProvider} or any
            class that responds to #identity(properties) and returns a {Smithy::Client::Identities::HttpLogin}.
          DOCS
          IdentityProvider.new(proc { |_properties| config.http_login_identity }) if config.http_login_identity
        end

        option(:http_basic_auth_scheme) do |_config|
          Smithy::Client::AuthSchemes::HttpBasic.new
        end
      end
    end
  end
end
