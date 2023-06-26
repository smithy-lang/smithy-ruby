# frozen_string_literal: true

require_relative 'interceptor/context'
require_relative 'interceptor/hook'

module Hearth
  # Module for Interceptors - allowing reading and modification or requests
  # and responses at various points during the operation lifecycle
  module Interceptor; end
end