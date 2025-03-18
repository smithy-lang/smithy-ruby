# frozen_string_literal: true

require 'smithy-client/auth_schemes/http_basic'

module Smithy
  module Client
    module Plugins
      # @api private
      class HttpBasicAuth < Plugin
        option(:http_basic_signer) do |_config|
          Signers::HttpBasic.new
        end

        option(:http_basic_auth_scheme) do |config|
          Smithy::Client::AuthSchemes::HttpBasic.new(signer: config.http_basic_signer)
        end
      end
    end
  end
end
