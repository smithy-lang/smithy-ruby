# frozen_string_literal: true

require_relative '../http_login_provider'
require_relative '../identities/http_login'
require_relative '../signers/http_digest'
require_relative '../auth_schemes/http_digest'

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

        option(:http_digest_auth_scheme) do |_config|
          Smithy::Client::AuthSchemes::HttpDigest.new
        end
      end
    end
  end
end
