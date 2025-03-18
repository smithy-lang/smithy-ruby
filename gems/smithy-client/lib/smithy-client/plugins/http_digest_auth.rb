# frozen_string_literal: true

require 'smithy-client/auth_schemes/http_digest'

module Smithy
  module Client
    module Plugins
      # @api private
      class HttpDigestAuth < Plugin
        option(:http_digest_signer) do |_config|
          Signers::HttpDigest.new
        end

        option(:http_digest_auth_scheme) do |config|
          Smithy::Client::AuthSchemes::HttpDigest.new(signer: config.http_digest_signer)
        end
      end
    end
  end
end
