# frozen_string_literal: true

module Smithy
  module Anvil
    # @api private
    module Client; end
  end
end

require_relative 'client/client_class'
require_relative 'client/endpoint_parameters'
require_relative 'client/endpoint_provider'
require_relative 'client/errors'
require_relative 'client/gemspec'
require_relative 'client/module'
require_relative 'client/types'
require_relative 'client/plugins/endpoint'
