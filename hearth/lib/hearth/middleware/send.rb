# frozen_string_literal: true

module Hearth
  module Middleware
    # A middleware used to send the request.
    class Send
      include Middleware::Logging

      # @param [Class] _app The next middleware in the stack.
      # @param [Boolean] stub_responses If true, a request is not sent and a
      #   stubbed response is returned.
      # @param [Class] stub_data_class A stub object that is responsible for
      #   creating a stubbed data response. It must respond to #stub and take
      #   the response and stub data as arguments.
      # @param [Array<Class>] stub_error_classes An array of error classes
      #   that are responsible for creating a stubbed error response. They
      #   must respond to #stub and take the response and stub data as
      #   arguments.
      # @param [#encode] stub_message_encoder a message encoder used to encode
      #   stubbed {Hearth::EventStream::Messages} to a transport specific
      #   binary format.
      # @param [EventStream::HandlerBase] event_handler Event stream handler -
      #   set only when the operation supports response event streaming.
      # @param [Stubs] stubs A {Hearth::Stubs} object containing
      #   stubbed data for any given operation.
      def initialize(_app, client:, stub_responses:,
                     stub_data_class:, stub_error_classes:,
                     stub_message_encoder:, event_handler:, stubs:)
        @client = client
        @stub_responses = stub_responses
        @stub_data_class = stub_data_class
        @stub_error_classes = stub_error_classes
        @stub_message_encoder = stub_message_encoder
        @response_events = !event_handler.nil?
        @event_handler = event_handler
        @stubs = stubs
      end

      # @param input
      # @param context
      # @return [Output]
      def call(input, context)
        interceptor_error = Interceptors.invoke(
          hook: Interceptor::MODIFY_BEFORE_TRANSMIT,
          input: input,
          context: context,
          output: nil,
          aggregate_errors: false
        )
        return Hearth::Output.new(error: interceptor_error) if interceptor_error

        interceptor_error = Interceptors.invoke(
          hook: Interceptor::READ_BEFORE_TRANSMIT,
          input: input,
          context: context,
          output: nil,
          aggregate_errors: false
        )
        return Hearth::Output.new(error: interceptor_error) if interceptor_error

        output = Output.new
        if @stub_responses
          stub_response(input, context, output)
        else
          send_request(context, output)
        end

        interceptor_error = Interceptors.invoke(
          hook: Interceptor::READ_AFTER_TRANSMIT,
          input: input,
          context: context,
          output: output,
          aggregate_errors: false
        )
        output.error = interceptor_error if interceptor_error

        output
      end

      private

      def stub_response(input, context, output)
        span_wrapper(context) do
          stub = @stubs.next(context.operation_name)
          log_debug(context, "Stubbing response with stub: #{stub}")
          if @response_events
            apply_event_stub(stub, input, context, output)
          else
            apply_stub(stub, input, context, output)
          end
          log_debug(context, "Stubbed response: #{context.response.inspect}")
        end
        return unless context.response.body.respond_to?(:rewind)

        context.response.body.rewind
      end

      def send_request(context, output)
        span_wrapper(context) do
          log_debug(context, "Sending request: #{context.request.inspect}")
          @client.transmit(
            request: context.request,
            response: context.response,
            logger: context.config.logger
          )
          log_debug(context, "Received response: #{context.response.inspect}")
        rescue Hearth::NetworkingError => e
          output.error = e
        end
      end

      def span_wrapper(context, &block)
        context.tracer.in_span(
          'Middleware.Send',
          attributes: context.request.span_attributes
        ) do |span|
          block.call
          span.add_attributes(context.response.span_attributes)
        end
      end

      def apply_stub(stub, input, context, output)
        case stub
        when Proc
          stub = stub.call(input)
          apply_stub(stub, input, context, output)
        when Exception, ApiError
          output.error = stub
        when Hash
          apply_stub_hash(stub, context)
        when NilClass
          apply_stub_nil(context)
        when Hearth::Structure
          apply_stub_hearth_structure(stub, context)
        when Hearth::Response
          context.response.replace(stub)
        else
          raise ArgumentError, 'Unsupported stub type'
        end
      end

      def apply_stub_hash(stub, context)
        if stub.key?(:error) && !stub.key?(:data)
          apply_stub_hash_error(stub, context)
        elsif stub.key?(:data) && !stub.key?(:error)
          apply_stub_hash_data(stub, context)
        else
          raise ArgumentError, 'Unsupported stub hash, must be :data or :error'
        end
      end

      def apply_stub_hash_data(stub, context)
        output = @stub_data_class.build(stub[:data], context: 'stub')
        @stub_data_class.validate!(output, context: 'stub')
        @stub_data_class.stub(context.response, stub: output)
      end

      def apply_stub_hash_error(stub, context)
        stub_error_class = stub_error_class(stub[:error][:class])
        output = stub_error_class.build(
          stub[:error][:data] || {},
          context: 'stub'
        )
        stub_error_class.validate!(output, context: 'stub')
        stub_error_class.stub(context.response, stub: output)
      end

      def stub_error_class(error_class)
        raise ArgumentError, 'Missing stub error class' unless error_class

        unless error_class.is_a?(Class)
          raise ArgumentError, 'Stub error class must be a class'
        end

        error_base_name = error_class.name.split('::').last
        stub_class = @stub_error_classes.find do |stub_error_class|
          stub_base_name = stub_error_class.name.split('::').last
          error_base_name == stub_base_name
        end
        raise ArgumentError, 'Unsupported stub error class' unless stub_class

        stub_class
      end

      def apply_stub_nil(context)
        output = @stub_data_class.build(
          @stub_data_class.default,
          context: 'stub'
        )
        @stub_data_class.validate!(output, context: 'stub')
        @stub_data_class.stub(context.response, stub: output)
      end

      def apply_stub_hearth_structure(stub, context)
        @stub_data_class.validate!(stub, context: 'stub')
        @stub_data_class.stub(context.response, stub: stub)
      end

      # rubocop:disable Metrics/CyclomaticComplexity
      def apply_event_stub(stub, input, context, output)
        case stub
        when Proc
          stub = stub.call(input)
          apply_event_stub(stub, input, context, output)
        when ApiError
          apply_stub_event_api_error(stub)
        when Exception
          output.error = stub
        when Hash
          apply_stub_hash_events(stub, context)
        when NilClass
          apply_stub_nil_event(context)
        when Hearth::Structure
          apply_initial_response_output(stub, context)
        when Hearth::Response
          apply_initial_response(stub, context)
        else
          raise ArgumentError, 'Unsupported stub type'
        end
      end
      # rubocop:enable Metrics/CyclomaticComplexity:

      def apply_stub_hash_events(stub, context)
        if (initial_response = stub[:initial_response])
          apply_initial_response_stub(initial_response, context)
        end
        stub[:events]&.each do |event|
          case event
          when EventStream::Message
            apply_stub_event_message(event, context)
          when Hearth::Structure
            apply_stub_event_structure(event, context)
          else
            raise ArgumentError, 'Unsupported event stub type'
          end
        end
      end

      def apply_stub_event_message(message, context)
        encoded = @stub_message_encoder.encode(message)
        context.response.body.write(encoded)
      end

      def apply_stub_event_structure(event, context)
        message = @stub_data_class.stub_event(event)
        apply_stub_event_message(message, context)
      end

      def apply_initial_response_stub(initial_response, context)
        case initial_response
        when Hearth::Structure
          apply_initial_response_output(initial_response, context)
        when Hash
          output = @stub_data_class.build(initial_response, context: 'stub')
          apply_initial_response_output(output, context)
        when Hearth::Response
          apply_initial_response(initial_response, context)
        else
          raise ArgumentError, 'Unsupported initial response type'
        end
      end

      def apply_initial_response_output(output, context)
        @stub_data_class.validate!(output, context: 'stub')
        decoder = context.response.body
        @stub_data_class.stub(context.response, stub: output)
        initial_message = context.response.body
        context.response.body = decoder

        return unless initial_message.is_a?(EventStream::Message)

        apply_stub_event_message(initial_message, context)
      end

      def apply_initial_response(response, context)
        if response.body.is_a?(EventStream::Message)
          initial_message = response.body
          encoded = @stub_message_encoder.encode(initial_message)
          response.body = StringIO.new(encoded)
        end

        context.response.replace(response)
      end

      def apply_stub_nil_event(context)
        apply_initial_response_stub(
          @stub_data_class.default,
          context
        )

        apply_stub_event_structure(
          @stub_data_class.default_event,
          context
        )
      end

      def apply_stub_event_api_error(api_error)
        return unless @event_handler

        @event_handler.emit_error(api_error)
      end
    end
  end
end
