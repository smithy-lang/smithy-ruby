# frozen_string_literal: true

# This is generated code!

require 'smithy-client'

Object.const_set('Weather', Module.new) unless Object.const_defined?('Weather')

# Provides weather forecasts.
module Weather
  VERSION = '1.0.0'
end

require_relative 'weather/types'
require_relative 'weather/paginators'
require_relative 'weather/schema'
require_relative 'weather/auth_parameters'
require_relative 'weather/auth_resolver'
require_relative 'weather/client'
require_relative 'weather/customizations'
require_relative 'weather/errors'
require_relative 'weather/endpoint_parameters'
require_relative 'weather/endpoint_provider'
require_relative 'weather/waiters'
