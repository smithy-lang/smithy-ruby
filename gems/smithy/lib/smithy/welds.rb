# frozen_string_literal: true

require_relative 'welds/anonymous_auth'
require_relative 'welds/endpoints'
require_relative 'welds/http_api_key_auth'
require_relative 'welds/http_basic_auth'
require_relative 'welds/http_bearer_auth'
require_relative 'welds/http_digest_auth'
require_relative 'welds/plugins'
require_relative 'welds/rpc_v2_cbor'
require_relative 'welds/rubocop'

module Smithy
  # @api private
  module Welds
    @welds = {}

    def self.load!(plan)
      Weld.subclasses.each { |weld| @welds[weld] = weld.new(plan) }
    end

    def self.for(service)
      @welds.each_value.select { |weld| weld.for?(service) }
    end
  end
end
