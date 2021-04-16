# frozen_string_literal: true

require_relative 'stubs'

module Seahorse

  # This module provides the ability to specify the data and/or errors to
  # return when a client is using stubbed responses.
  # This module should be included in generated service clients.
  #
  # Pass `stub_responses: true` to a client constructor to enable this
  # behavior.
  #
  module ClientStubs

    # Configures what data / errors should be returned from the named operation
    # when response stubbing is enabled.
    #
    # ## Basic usage
    #
    # When you enable response stubbing, the client will generate fake
    # responses and will not make any HTTP requests.
    #
    #     client = Service::Client.new(stub_responses: true)
    #     client.operation
    #     #=> #<struct Service:Types::Operation param1=[], param2=nil>
    #
    # You can provide stub data that will be returned by the client.
    #
    #     # stub data in the constructor
    #     client = Service::Client.new(stub_responses: {
    #       operation: { param1: [{name: 'value1' }] },
    #       operation2: { body: 'data' },
    #     })
    #
    #     client.operation.param1.map(&:name) #=> ['value1']
    #     client.operation2().body.read #=> 'data'
    #
    # You can also specify the stub data using {#stub_responses}
    #
    #     client = Service::Client.new(stub_responses: true)
    #     client.stub_responses(:operation1, {
    #       param1: [{ name: 'value1' }]
    #     })
    #
    #     client.operation.param1.map(&:name)
    #     #=> ['value1']
    #
    # ## Dynamic Stubbing
    #
    # In addition to creating static stubs, it's also possible to generate
    # stubs dynamically based on the parameters with which operations were
    # called, by passing a `Proc` object:
    #
    #     client = Service::Client.new(stub_responses: true)
    #     client.stub_responses(:operation, -> (context) {
    #       client.stub_responses(:operation2, content_type: context.params[:content_type])
    #     })
    #
    # ## Stubbing Errors
    #
    # When stubbing is enabled, the SDK will default to generate
    # fake responses with placeholder values. You can override the data
    # returned. You can also specify errors it should raise.
    #
    #     # to simulate errors, give the error class, you must
    #     # be able to construct an instance with `.new`
    #     client.stub_responses(:operation, Timeout::Error)
    #     client.operation(param1: 'value')
    #     #=> raises new Timeout::Error
    #
    #     # or you can give an instance of an error class
    #     client.stub_responses(:operation, RuntimeError.new('custom message'))
    #     client.operation(param1: 'value')
    #     #=> raises the given runtime error object
    #
    # ## Stubbing HTTP Responses
    #
    # As an alternative to providing the response data, you can provide
    # an HTTP response.
    #
    #     client.stub_responses(:operation, {
    #       status_code: 200,
    #       headers: { 'header-name' => 'header-value' },
    #       body: "...",
    #     })
    #
    # To stub a HTTP response, pass a Hash with all three of the following
    # keys set:
    #
    # * **`:status_code`** - <Integer> - The HTTP status code
    # * **`:headers`** - Hash<String,String> - A hash of HTTP header keys and values
    # * **`:body`** - <String,IO> - The HTTP response body.
    #
    # ## Stubbing Multiple Responses
    #
    # Calling an operation multiple times will return similar responses.
    # You can configure multiple stubs and they will be returned in sequence.
    #
    #     client.stub_responses(:operation, [
    #       Errors::NotFound,
    #       { content_length: 150 },
    #     ])
    #
    #     client.operation(param1: 'value1')
    #     #=> raises Errors::NotFound
    #
    #     resp = client.operation(param1: 'value2')
    #     resp.content_length #=> 150
    #
    # @param [Symbol] operation_name
    #
    # @param [Mixed] stubs One or more responses to return from the named
    #   operation.
    #
    # @return [void]
    #
    # @raise [RuntimeError] Raises a runtime error when called
    #   on a client that has not enabled response stubbing via
    #   `:stub_responses => true`.
    def stub_responses(operation_name, *stubs)
      if @stub_responses
        @stubs ||= Seahorse::Stubbing::Stubs.new
        @stubs.add_stubs(operation_name, stubs.flatten)
      else
        msg = 'stubbing is not enabled; enable stubbing in the constructor '\
              'with `:stub_responses => true`'
        raise ArgumentError, msg
      end
    end
  end
end
