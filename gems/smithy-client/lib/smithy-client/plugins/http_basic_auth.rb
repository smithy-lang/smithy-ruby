# frozen_string_literal: true

require_relative '../login'
require_relative '../login_provider'
require_relative '../login_signer'

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

        option(:login_signer) do |_config|
          LoginSigner.new(scheme_id: 'smithy.api#httpBasicAuth')
        end

        def after_initialize(client)
          client.config.auth_schemes['smithy.api#httpBasicAuth'] = AuthScheme.new(
            identity_provider: client.config.login_provider,
            scheme_id: 'smithy.api#httpBasicAuth',
            signer: client.config.login_signer
          )
        end
      end
    end
  end
end
