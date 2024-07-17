require_relative 'http2/client'
require_relative 'http2/request'
require_relative 'http2/response'

module Hearth
  # HTTP2 namespace for HTTP2 specific functionality.
  module HTTP2
    class NetworkingError < Hearth::NetworkingError; end

    class ConnectionClosedError < Hearth::NetworkingError; end
  end
end