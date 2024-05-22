
module Hearth
  module HTTP2
    # Generic StreamExchange class - streams must follow this interface
class StreamExchange
  # send headers over the stream
  def headers(headers, end_stream: false); end

  # send data
  def data(data, end_stream: false); end

  def on(event, &block)
    # supported events:
    # :headers
    # :data
    # :close
  end
end
  end
end