# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

require 'hearth'
require_relative 'rpcv2_cbor/auth'
require_relative 'rpcv2_cbor/builders'
require_relative 'rpcv2_cbor/client'
require_relative 'rpcv2_cbor/config'
begin
  require_relative 'rpcv2_cbor/customizations'
rescue LoadError; end
require_relative 'rpcv2_cbor/errors'
require_relative 'rpcv2_cbor/endpoint'
require_relative 'rpcv2_cbor/middleware'
require_relative 'rpcv2_cbor/paginators'
require_relative 'rpcv2_cbor/params'
require_relative 'rpcv2_cbor/parsers'
require_relative 'rpcv2_cbor/stubs'
require_relative 'rpcv2_cbor/telemetry'
require_relative 'rpcv2_cbor/types'
require_relative 'rpcv2_cbor/validators'
require_relative 'rpcv2_cbor/waiters'

module Rpcv2Cbor
  VERSION = File.read(File.expand_path('../VERSION', __dir__)).strip
end
