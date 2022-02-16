# frozen_string_literal: true

require_relative 'stubs'

module Hearth
  # This module provides the ability to specify the data and/or errors to
  # return when a client is using stubbed responses.
  # This module should be included in generated service clients.
  #
  # Pass `stub_responses: true` to a client constructor to enable this
  # behavior.
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
    # You can specify the stub data using {#stub_responses}
    #
    #     client = Service::Client.new(stub_responses: true)
    #     client.stub_responses(:operation, {
    #       param1: [{ name: 'value1' }]
    #     })
    #
    #     client.operation.param1.map(&:name)
    #     #=> ['value1']
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
    # ## Dynamic Stubbing
    #
    # In addition to creating static stubs, it's also possible to generate
    # stubs dynamically based on the parameters with which operations were
    # called, by passing a `Proc` object:
    #
    #     client.stub_responses(:operation, -> (context) {
    #       if context.params[:param] == 'foo'
    #         # return a stub
    #         { param1: [{ name: 'value1'}]}
    #       else
    #         # return an error
    #         Services::Errors::NotFound
    #       end
    #     })
    #
    # ## Stubbing Raw Protocol Responses
    #
    # As an alternative to providing the response data, you can modify the
    # response object provided by the `Proc` object and then
    # return nil.
    #
    #     client.stub_responses(:operation, -> (context) {
    #       context.response.status = 404 # simulate an error
    #       nil
    #     })
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
        @stubs.add_stubs(operation_name, stubs.flatten)
      else
        msg = 'Stubbing is not enabled. Enable stubbing in the constructor '\
              'with `stub_responses: true`'
        raise ArgumentError, msg
      end
    end
  end
end
