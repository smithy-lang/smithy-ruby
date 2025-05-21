# frozen_string_literal: true

module Smithy
  module Views
    # @api private
    module Client; end
  end
end

# helper classes
require_relative 'client/auth_parameter'
require_relative 'client/endpoint_parameter'
require_relative 'client/operation_examples'
require_relative 'client/plugin'
require_relative 'client/plugin_list'
require_relative 'client/request_response_example'
require_relative 'client/shape_to_hash'

# views
require_relative 'client/auth_parameters'
require_relative 'client/auth_parameters_rbs'
require_relative 'client/auth_plugin'
require_relative 'client/auth_resolver'
require_relative 'client/auth_resolver_rbs'
require_relative 'client/client'
require_relative 'client/client_rbs'
require_relative 'client/customizations'
require_relative 'client/endpoint_parameters'
require_relative 'client/endpoint_parameters_rbs'
require_relative 'client/endpoint_plugin'
require_relative 'client/endpoint_provider'
require_relative 'client/endpoint_provider_rbs'
require_relative 'client/endpoint_provider_spec'
require_relative 'client/errors'
require_relative 'client/errors_rbs'
require_relative 'client/gemspec'
require_relative 'client/module'
require_relative 'client/module_rbs'
require_relative 'client/paginators'
require_relative 'client/protocol_spec'
require_relative 'client/rubocop_yml'
require_relative 'client/schema'
require_relative 'client/schema_rbs'
require_relative 'client/spec_helper'
require_relative 'client/types'
require_relative 'client/types_rbs'
require_relative 'client/waiters'
