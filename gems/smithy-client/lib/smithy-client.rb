# frozen_string_literal: true

require 'base64'
require 'bigdecimal'
require 'jmespath'

require 'smithy-cbor'
require 'smithy-schema'

# client

require_relative 'smithy-client/block_io'
require_relative 'smithy-client/configuration'
require_relative 'smithy-client/default_params'
require_relative 'smithy-client/dynamic_errors'
require_relative 'smithy-client/endpoint_rules'
require_relative 'smithy-client/handler'
require_relative 'smithy-client/handler_builder'
require_relative 'smithy-client/handler_context'
require_relative 'smithy-client/handler_list'
require_relative 'smithy-client/handler_list_entry'
require_relative 'smithy-client/managed_file'
require_relative 'smithy-client/networking_error'
require_relative 'smithy-client/pageable_response'
require_relative 'smithy-client/param_converter'
require_relative 'smithy-client/param_validator'
require_relative 'smithy-client/plugin'
require_relative 'smithy-client/plugin_list'
require_relative 'smithy-client/retry'
require_relative 'smithy-client/service_error'
require_relative 'smithy-client/util'
require_relative 'smithy-client/waiters/poller'
require_relative 'smithy-client/waiters/waiter'
require_relative 'smithy-client/request'
require_relative 'smithy-client/response'
require_relative 'smithy-client/base'

# client http

require_relative 'smithy-client/http/error_inspector'
require_relative 'smithy-client/http/headers'
require_relative 'smithy-client/http/response'
require_relative 'smithy-client/http/request'
require_relative 'smithy-client/net_http/connection_pool'
require_relative 'smithy-client/net_http/handler'

# identity and auth

require_relative 'smithy-client/identity'
require_relative 'smithy-client/refreshing_identity_provider'
require_relative 'smithy-client/signer'

# protocols

require_relative 'smithy-client/rpc_v2_cbor/protocol'

# stubbing

require_relative 'smithy-client/stubs'
require_relative 'smithy-client/stubbing'

module Smithy
  # Base module for a generated Smithy gem.
  module Client
    VERSION = File.read(File.expand_path('../VERSION', __dir__.to_s)).strip
  end
end
