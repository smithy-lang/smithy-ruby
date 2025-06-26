# frozen_string_literal: true

require_relative '../http_login_provider'
require_relative '../identities/http_login'
require_relative '../signers/http_basic'

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

        class Handler < Client::Handler
          def call(context)
            if context.auth[:scheme_id] == 'smithy.api#httpBasicAuth'
              Smithy::Client::Signers::HttpBasic.new.sign(context)
            end
            @handler.call(context)
          end
        end

        handler(Handler, step: :sign)
      end
    end
  end
end
