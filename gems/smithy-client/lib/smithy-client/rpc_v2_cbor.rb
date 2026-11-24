# frozen_string_literal: true

module Smithy
  module Client
    # Protocol implementation for Smithy RPC v2 CBOR. Serializes requests and
    # deserializes responses (and errors) for the +smithy.protocols#rpcv2Cbor+
    # wire format, and builds stubbed responses for testing.
    # @api private
    class RpcV2Cbor
      def initialize
        @codec = Smithy::Cbor::Codec.new
      end

      # Serialize the request into the RPC v2 CBOR wire format.
      # @param [HandlerContext] context
      def build_request(context)
        context.http_request.http_method = 'POST'
        apply_headers(context)
        apply_body(context)
        apply_url_path(context)
      end

      # Deserialize a successful response body.
      # @param [HandlerContext] context
      # @return [Object] the parsed output data
      def parse_data(context)
        @codec.parse(context.operation.output, context.http_response.body.read)
      end

      # Deserialize an error response into the modeled error. Called on every
      # response; returns nil when the response is not an error.
      # @param [HandlerContext] context
      # @return [StandardError, nil]
      def parse_error(context)
        status_code = context.http_response.status_code
        return unless status_code >= 200 && status_code <= 599 # rubocop:disable Style/ComparableBetween

        # Malformed responses should raise an http-based error, so we validate
        # the protocol header across the full 200..599 range.
        unless valid_response?(context)
          code, data = http_status_error(context)
          return build_error(context, code, data)
        end
        return unless status_code >= 400 && status_code <= 599 # rubocop:disable Style/ComparableBetween

        error(context)
      end

      # Build a stubbed HTTP response for the given output data.
      # @param [Configuration] _config
      # @param [Schema::OperationShape] operation
      # @param [Object] data
      # @return [Http::Response]
      def stub_data(_config, operation, data)
        response = Http::Response.new
        response.status_code = 200
        response.headers['Smithy-Protocol'] = 'rpc-v2-cbor'
        response.headers['Content-Type'] = 'application/cbor'
        response.body = @codec.build(operation.output, data)
        response
      end

      # Build a stubbed HTTP error response for the given error code.
      # @param [Configuration] _config
      # @param [String] error_code
      # @return [Http::Response]
      def stub_error(_config, error_code)
        response = Http::Response.new
        response.status_code = 400
        response.headers['Smithy-Protocol'] = 'rpc-v2-cbor'
        response.headers['Content-Type'] = 'application/cbor'
        data = { '__type' => "smithy.ruby.tests##{error_code}", 'message' => 'stubbed-error-message' }
        response.body = Smithy::Cbor.encode(data)
        response
      end

      private

      def apply_headers(context)
        context.http_request.headers['Smithy-Protocol'] = 'rpc-v2-cbor'
        apply_content_type_header(context)
        apply_accept_header(context)
      end

      def apply_content_type_header(context)
        input = context.operation.input
        content_type =
          if event_stream?(input)
            'application/vnd.amazon.eventstream'
          elsif input != Schema::Shapes::Prelude::Unit
            'application/cbor'
          end

        context.http_request.headers['Content-Type'] ||= content_type if content_type
      end

      def apply_accept_header(context)
        accept =
          if event_stream?(context.operation.output)
            'application/vnd.amazon.eventstream'
          else
            'application/cbor'
          end

        context.http_request.headers['Accept'] ||= accept
      end

      def apply_body(context)
        context.http_request.body = @codec.build(context.operation.input, context.params)
      end

      # URI#path= checks the whole path against the URI parser's regexp on every call. The last path it accepted for
      # an operation is kept on the operation shape, with what the check depended on: the URI class, its parser and
      # the base path. A URI that matches all three, has a host and no opaque part gets that path without the check.
      # Only URI classes whose #path=, #check_path and #set_path are URI::Generic's are cached.
      def apply_url_path(context)
        uri = context.http_request.endpoint
        operation = context.operation
        checked = operation[:rpc_v2_cbor_checked_path]
        return uri.send(:set_path, checked[3]) if checked && same_path_check?(checked, uri)

        base = uri.path
        uri.path = base + operation_path(context)
        operation[:rpc_v2_cbor_checked_path] = checked_path(uri, base) if cacheable_path?(uri)
      end

      # [URI class, parser, base path, full path], in the order #same_path_check? and #apply_url_path read them.
      def checked_path(uri, base)
        [uri.class, uri.parser, base, uri.path].freeze
      end

      def operation_path(context)
        "/service/#{context.config.service.name}/operation/#{context.operation.name}"
      end

      def same_path_check?(checked, uri)
        checked[0].equal?(uri.class) && checked[1].equal?(uri.parser) && checked[2] == uri.path && host_path?(uri)
      end

      def cacheable_path?(uri)
        host_path?(uri) &&
          %i[path= check_path set_path].all? { |name| uri.class.instance_method(name).owner == URI::Generic }
      rescue NameError
        false
      end

      # A URI whose path is checked as an absolute path: it has a host and no opaque part.
      def host_path?(uri)
        uri.host && uri.opaque.nil?
      end

      def event_stream?(input_shape)
        Schema::Extension.event_stream_member(input_shape)
      end

      def valid_response?(context)
        req_header = context.http_request.headers['smithy-protocol']
        resp_header = context.http_response.headers['smithy-protocol']
        req_header == resp_header
      end

      def error(context)
        body = context.http_response.body.read
        code, data =
          if body.empty?
            http_status_error(context)
          else
            extract_error(body, context)
          end
        build_error(context, code, data)
      end

      def extract_error(body, context)
        # Raw decode to read __type before the modeled error shape is known (@codec.parse needs a shape; see below).
        data = Smithy::Cbor.decode(body)
        code = error_code(context, data)
        data = parse_error_data(context, body, code)
        [code, data]
      # TODO: Preserve a decoded modeled error code when parsing its data fails.
      rescue Smithy::Cbor::ParseError
        [http_status_error_code(context), Schema::EmptyStructure.new]
      end

      def parse_error_data(context, body, code)
        data = Schema::EmptyStructure.new
        context.operation.errors.each do |err_shape|
          next unless err_shape.name == code

          data = @codec.parse(err_shape, body, err_shape.type.new)
        end
        data
      end

      def error_code(context, data)
        code = data['__type']
        code ||= http_status_error_code(context)
        code.split('#').last.split('$').first
      end

      def build_error(context, code, data)
        errors_module = context.client.class.errors_module
        errors_module.error_class(code).new(context, data)
      end

      def http_status_error(context)
        [http_status_error_code(context), Schema::EmptyStructure.new]
      end

      def http_status_error_code(context)
        "HTTP#{context.http_response.status_code}Error"
      end
    end
  end
end
