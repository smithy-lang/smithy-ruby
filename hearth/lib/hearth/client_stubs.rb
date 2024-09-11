# frozen_string_literal: true

module Hearth
  # This module provides the ability to specify the data and/or errors to
  # return when a client is using stubbed responses.
  # This module should be included in generated service clients.
  #
  # Pass `stub_responses: true` to a Client's Config constructor
  # to enable this behavior.
  module ClientStubs
    # Configures what data / errors should be returned from the named operation
    # when response stubbing is enabled.
    #
    # ## Basic usage
    #
    # When you enable response stubbing, the client will generate fake
    # responses and will not make any HTTP requests. The SDK will default
    # to generate fake responses with placeholder values. You can override
    # the data returned using {#stub_responses}. You can also specify errors
    # (with error data) that it should raise.
    #
    #     client = Service::Client.new(stub_responses: true)
    #     client.operation
    #     #=> #<struct Service:Types::Operation param1=[], param2=nil>
    #
    # You can specify the modeled stub data using the :data key.
    #
    #     client = Service::Client.new(stub_responses: true)
    #     client.stub_responses(
    #       :operation,
    #       data: { param1: [{ name: 'value1' }] }
    #     )
    #     client.operation.param1.map(&:name)
    #     #=> ['value1']
    #
    # Stub data can also be provided as an output Type.
    #
    #     client = Service::Client.new(stub_responses: true)
    #     output = Service::Types::OperationOutput.new(
    #       param1: [{ name: 'value1' }]
    #     )
    #     client.stub_responses(:operation, output)
    #     client.operation(param1: 'value')
    #     #=> #<struct Service:Types::OperationOutput ..>
    #
    # You can also specify modeled errors or exceptions it should raise using
    # the :error key. The error hash must have a :class and optionally any
    # :data to populate the error with.
    #
    #     client = Service::Client.new(stub_responses: true)
    #     client.stub_responses(
    #       :operation,
    #       error: { class: ModeledError, data: { message: 'error message' } }
    #     )
    #     #=> raises ModeledError.new('error message')
    #
    # Constructed Exceptions will also be raised if provided.
    #
    #     client.stub_responses(:operation, Hearth::NetworkingError.new)
    #     client.operation(param1: 'value')
    #     #=> raises Hearth::NetworkingError
    #
    # ## Dynamic Stubbing
    #
    # In addition to creating static stubs, it's also possible to generate
    # stubs dynamically based on the input with which operations were
    # called, by passing a `Proc` object:
    #
    #     client.stub_responses(:operation, -> (input) {
    #       if input[:param] == 'foo'
    #         # return a data stub
    #         { data: { param1: [{ name: 'value1'}]} }
    #       else
    #         # return an error stub
    #         { error: Service::Errors::NotFound }
    #       end
    #     })
    #
    # ## Stubbing Raw Protocol Responses
    #
    # As an alternative to providing the response data, you can provide an
    # instance of Hearth::Response to stub with.
    #
    #     response = Hearth::HTTP::Response.new(
    #       status: 200,
    #       body: StringIO.new('{param1: "value1"}'),
    #     )
    #     client.stub_responses(:operation, response)
    #     #=> #<struct Service:Types::OperationOutput param1="value1">
    #
    # ## Stubbing Multiple Responses
    #
    # Calling an operation multiple times will return similar responses.
    # You can configure multiple stubs and they will be returned in sequence.
    #
    #     client.stub_responses(
    #       :operation,
    #       { error: Service::Errors::NotFound },
    #       { data: { content_length: 150 } },
    #     ])
    #
    #     client.operation(param1: 'value1')
    #     #=> raises Service::Errors::NotFound
    #
    #     resp = client.operation(param1: 'value2')
    #     resp.data.content_length #=> 150
    #
    # ## Stubbing Event Stream operations
    #
    # Operations with event stream responses may also be stubbed using
    # {#stub_responses} to stub both initial responses and events.
    # By default, the SDK will generate a fake initial response and event.
    #
    #     client = Service::Client.new(stub_responses: true)
    #     handler = Service::EventStreams::EventStreamOperationHandler.new
    #     handler.on_initial_response { |event| # default initial response }
    #     handler.on_event_1 { |event| # default event }
    #     client.event_stream_operation({}, event_stream_handler: handler)
    #
    # You may specify events and initial responses together using the :events
    # and :initial_responses keys.
    #
    #     client = Service::Client.new(stub_responses: true)
    #     client.stub_responses(:event_stream_operation, {
    #       events: [Service::Types:::MyEvent.new(message: 'message')],
    #       initial_response: { params1: 'value1' }
    #     })
    #     handler = Service::EventStreams::EventStreamOperationHandler.new
    #     handler.on_initial_response { |event| # stubbed initial response }
    #     handler.on_my_event { |event| # stubbed MyEvent }
    #     client.event_stream_operation({}, event_stream_handler: handler)
    #
    # :events may be either an event Type or a {EventStream::Message}.
    # :initial_response may be the operation's output Type, a hash with the
    # outputs parameters, or a protocol Response. If the :initial_response is
    # a Response, then the body should be unset or an {EventStream::Message}.
    # Stubbed event stream events and initial responses will trigger synchronous
    # calls to registered event stream handlers.
    #
    # ## Stubbing Event Stream Errors
    #
    # You may stub event stream errors in a number of different ways, depending
    # on the type of error.  For Exceptions raised during the request and
    # when connecting, you may pass the exception and the operation call will
    # raise the error:
    #     client.stub_responses(
    #       :event_stream_operation, Hearth::NetworkingError.new)
    #     client.event_stream_operation
    #     #=> raises Hearth::NetworkingError
    #
    # To stub modeled/service errors, you may pass an instance of the error and
    # the registered error handlers will be called.
    #
    #     client.stub_responses(
    #       :event_stream_operation, Service::ClientError.new)
    #     handler = Service::EventStreams::EventStreamOperationHandler.new
    #     handler.on_error { |e| # ClientError }
    #     client.event_stream_operation({}, event_stream_handler: handler)
    #
    # ## Dynamic stubbing for event streams
    #
    # Similar to regular operations, event streaming operations also support
    # dynamic stubbing based on the input by passing a `Proc` object which
    # returns any of the supported stubs types.
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
      if @config.stub_responses
        @config.stubs.set_stubs(operation_name, stubs.flatten)
      else
        msg = 'Stubbing is not enabled. Enable stubbing in Config ' \
              'with `stub_responses: true`'
        raise ArgumentError, msg
      end
    end
  end
end
