# frozen_string_literal: true

require 'smithy-client/auth_schemes/anonymous'

module Smithy
  module Client
    module Plugins
      # @api private
      class AnonymousAuth < Plugin
        option(:anonymous_identity) do
          Identities::Anonymous.new
        end

        option(:anonymous_identity_provider) do |config|
          IdentityProvider.new(proc { config.anonymous_identity }) if config.anonymous_identity
        end

        option(:anonymous_signer) do |_config|
          Signers::Anonymous.new
        end

        option(:anonymous_auth_scheme) do |config|
          Smithy::Client::AuthSchemes::Anonymous.new(signer: config.anonymous_signer)
        end
      end
    end
  end
end
