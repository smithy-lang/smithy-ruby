# frozen_string_literal: true

require_relative 'interceptor/hooks'

module Hearth
  # Module for Interceptors - a generic extension point that allows injecting
  # logic at specific stages of execution within the SDK. Logic injection is
  # done with hooks that the interceptor implements.
  #
  # Hooks are either read-only or read/write.
  # Read-only hooks allow an interceptor to read the input,
  # transport request, transport response or output messages.
  # Read/write hooks allow an interceptor to modify one of these messages.
  module Interceptor; end
end
