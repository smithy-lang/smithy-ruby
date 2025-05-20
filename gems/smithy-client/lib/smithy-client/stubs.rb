# frozen_string_literal: true

module Smithy
  module Client
    # This module provides the ability to specify the data and/or errors to
    # return when a client is using stubbed responses.
    module Stubs
      # Configures what data / errors should be returned from the named operation
      # when response stubbing is enabled.
      #
      # ## Basic usage
      #
      # When you enable response stubbing, the client will generate fake
      # responses and will not make any HTTP requests:
      #
      #     client = Weather::Client.new(stub_responses: true)
      #     client.get_current_time
      #     #=> #<struct Weather::GetCurrentTimeOutput time=2025-01-20 12:00:00 -0500>
      #
      # You can specify the stub data using {#stub_responses}:
      #
      #     time = Time.now #=> 2025-01-20 12:00:00 -0500
      #     client.stub_responses(:get_current_time, { time: time })
      #     client.get_current_time.time #=> 2025-01-20 12:00:00 -0500
      #
      # ## Dynamic Stubbing
      #
      # In addition to creating static stubs, it's also possible to generate
      # stubs dynamically based on the parameters with which operations were
      # called, by passing a `Proc` object:
      #
      #     time = Time.now #=> 2025-01-20 12:00:00 -0500
      #     client.stub_responses(:get_current_time, ->(context) do
      #         if context.params[:time] == time
      #           { time: time + 60 }
      #         else
      #           { time: time }
      #         end
      #       end
      #     )
      #
      # The yielded object is an instance of {Smithy::Client::HandlerContext}.
      #
      # ## Stubbing Errors
      #
      # When stubbing is enabled, the SDK will default to generate
      # fake responses with placeholder values. You can override the data
      # returned. You can also specify errors it should raise:
      #
      #     # To simulate service errors, give the error code:
      #     client.stub_responses(:get_city, 'NoSuchResource')
      #     client.get_city(city_id: 'Winchester')
      #     #=> raises Weather::Errors::NoSuchResource
      #
      #     # To simulate other errors, give the error class.
      #     # You must be able to construct an instance with `.new`:
      #     client.stub_responses(:get_city, Timeout::Error)
      #     client.get_city(city_id: 'Winchester')
      #     #=> raises new Timeout::Error
      #
      #     # Or you can give an instance of an error class:
      #     error = RuntimeError.new('oops')
      #     client.stub_responses(:get_city, error)
      #     client.get_city(city_id: 'Winchester')
      #     #=> raises error
      #
      # ## Stubbing HTTP Responses
      #
      # As an alternative to providing the response data, you can provide
      # an HTTP response:
      #
      #     client.stub_responses(:get_current_time, {
      #       status_code: 200,
      #       headers: { 'header-name' => 'header-value' },
      #       body: "payload",
      #     })
      #
      # To stub an HTTP response, pass a Hash with all three of the following
      # keys set:
      #
      # * **`:status_code`** - `Integer` - The HTTP status code
      # * **`:headers`** - `Hash<String, String>` - A hash of HTTP header keys and values
      # * **`:body`** - `<String, IO>` - The HTTP response body.
      #
      # ## Stubbing Multiple Responses
      #
      # Calling an operation multiple times will return similar responses.
      # You can configure multiple stubs, and they will be returned in sequence:
      #
      #     client.stub_responses(:get_city, [
      #       'NoSuchResource',
      #       { name: 'Winchester', coordinates: { latitude: 39.1825, longitude: -78.1676 } }
      #     ])
      #
      #     client.get_city(city_id: "Winchester')
      #     #=> raises Weather::Errors::NoSuchResource
      #
      #     output = client.get_city(city_id: "Winchester')
      #     output.name #=> 'Winchester'
      #     output.coordinates.latitude #=> 39.1825
      #     output.coordinates.longitude #=> -78.1676
      #
      # @param [Symbol] operation_name
      # @param [Mixed] stubs One or more responses to return from the named operation.
      # @raise [RuntimeError] Raises a runtime error when called on a client
      #  that has not enabled response stubbing with `stub_responses: true`.
      def stub_responses(operation_name, *stubs)
        unless @config.stub_responses
          raise 'stubbing is not enabled; enable stubbing in the constructor ' \
                'with `stub_responses: true`'
        end
        apply_stubs(operation_name, stubs.flatten)
      end

      # Generates and returns stubbed response data from the named operation.
      #
      #     client = Weather::Client.new
      #     client.stub_data(:get_current_time)
      #     #=> #<struct Weather::Types::GetCurrentTimeOutput time=2025-01-20 12:00:00 -0500>
      #
      # In addition to generating default stubs, you can provide data to apply to the response stub.
      #
      #     time = Time.now #=> 2025-01-20 12:00:00 -0500
      #     client.stub_data(:get_current_time, { time: time + 60 })
      #     #=> #<struct Weather::Types::GetCurrentTimeOutput time=2025-01-20 12:01:00 -0500>
      #
      # @param [Symbol] operation_name
      # @param [Hash] data
      # @return [Structure] Returns a stubbed response data structure.
      def stub_data(operation_name, data = {})
        Stubbing::StubData.new(@config.service.operation(operation_name)).stub(data)
      end

      # Allows you to access all the requests that the stubbed client has made.
      # @return [Array] Returns an array of the api requests made. Each request
      #  object contains keys: :operation_name, :params and :context.
      # @raise [RuntimeError] Raises a runtime error when called on a client
      #  that has not enabled response stubbing with `stub_responses: true`.
      def api_requests
        unless @config.stub_responses
          raise 'stubbing is not enabled; enable stubbing in the constructor ' \
                'with `stub_responses: true`'
        end
        @config.api_requests_mutex.synchronize { @config.api_requests }
      end

      # @api private
      def next_stub(context)
        operation_name = context.operation_name
        stub = @config.stubs_mutex.synchronize do
          stubs = @config.stubs[operation_name] || []
          case stubs.length
          when 0 then stub_data(operation_name)
          when 1 then stubs.first
          else stubs.shift
          end
        end
        stub = convert_stub(operation_name, stub, context)
        stub[:mutex] = Mutex.new
        stub
      end

      private

      def apply_stubs(operation_name, stubs)
        @config.stubs_mutex.synchronize do
          @config.stubs[operation_name] = stubs
        end
      end

      # This method converts the given stub data and converts it to a
      # HTTP response (when possible). This enables the response stubbing
      # plugin to provide a HTTP response that triggers all normal events
      # during response handling.
      def convert_stub(operation_name, stub, context)
        case stub
        when Proc then convert_stub(operation_name, stub.call(context), context)
        when Exception, Class then { error: stub }
        when String then service_error_stub(stub)
        else http_response_stub(operation_name, stub)
        end
      end

      def service_error_stub(error_code)
        { http: @config.protocol.stub_error(@config.service, error_code) }
      end

      def http_response_stub(operation_name, data)
        if data.is_a?(Hash) && data.keys.sort == %i[body headers status_code]
          { http: hash_to_http_resp(data) }
        else
          { http: data_to_http_resp(operation_name, data) }
        end
      end

      def hash_to_http_resp(data)
        http_resp = HTTP::Response.new
        http_resp.status_code = data[:status_code]
        http_resp.headers.update(data[:headers])
        http_resp.body = data[:body]
        http_resp
      end

      def data_to_http_resp(operation_name, data)
        operation = @config.service.operation(operation_name)
        data = ParamConverter.new(operation.output, convert_structures: false).convert(data)
        ParamValidator.new(operation.output, validate_required: false).validate!(data, context: 'stub')
        @config.protocol.stub_data(@config.service, operation, data)
      end
    end
  end
end
