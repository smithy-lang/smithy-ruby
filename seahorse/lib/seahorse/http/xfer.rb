# frozen_string_literal: true

require 'curb'
require 'stringio'

module Seahorse
  module HTTP
    # Transmits an HTTP {Request} object, returning an HTTP {Response}.
    class Xfer

      def initialize
        @curl = curl_handle
      end

      # @param [Request] http_req
      # @param [Response] http_resp
      # @return [Response]
      def transmit(http_req:, http_resp:)
        setup_req_url(http_req)
        setup_req_headers(http_req)
        setup_resp_header_events(http_resp)
        setup_resp_body_events(http_resp)
        setup_resp_complete_event(http_resp)
        send("xfer_#{http_req.http_method.downcase}_request", http_req)
        http_resp
      rescue StandardError => error
        raise NetworkingError, error
      end

      private

      def setup_req_url(req)
        @curl.url = req.url
        @curl.verbose = true
      end

      def setup_req_headers(req)
        @curl.headers = {}
        req.headers.each do |key, value|
          @curl.headers[key] = value
        end
        @curl.headers['Content-Length'] ||= req.body.size
      end

      def setup_resp_header_events(resp)
        @curl.on_header do |header_data|
          if header_data[0..4] == 'HTTP/'
            resp.status_code = header_data.split(' ')[1].to_i
          elsif (matches = header_data.match(/^(\S+): (.+)\r\n/))
            resp.headers[matches[1]] = matches[2]
          end
          header_data.bytesize
        end
      end

      def setup_resp_body_events(resp)
        @curl.on_body do |data|
          resp.body.write(data)
          data.bytesize
        end
      end

      def setup_resp_complete_event(resp)
        @curl.on_complete do
          resp.body.rewind if resp.body.respond_to?(:rewind)
        end
      end

      def xfer_delete_request(req)
        @curl.post_body = req.body.read
        @curl.http_delete
      end

      def xfer_get_request(req)
        @curl.post_body = req.body.read
        @curl.http_get
      end

      def xfer_put_request(req)
        @curl.http_put(req.body)
      end

      def xfer_post_request(req)
        @curl.http_post(req.body)
      end

      def xfer_head_request(req)
        @curl.post_body = req.body.read
        @curl.http_head
      end

      def curl_handle
        Thread.current[:naws_http_curl] ||= Curl::Easy.new
      end

    end
  end
end

# The curb gem assumes all IO objects are files and that they
# respond to `#stat`. In order to stream from a StringIO, this
# method is being patched on. For performance reasons, I chose
# not to wrap the string io with a delegate.
# @api private
class StringIO

  Stat = Struct.new(:size)

  def stat
    Stat.new(size)
  end

end
