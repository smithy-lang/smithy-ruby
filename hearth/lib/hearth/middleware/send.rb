# frozen_string_literal: true

module Hearth
  module Middleware
    # A middleware used to send the request.
    # @api private
    class Send
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
      # @param [Class] params_class A Params class responsible for
      #   converting a ruby hash into the operation's modeled output Type.
      # @param [Stubs] stubs A {Hearth::Stubbing:Stubs} object containing
      #   stubbed data for any given operation.
      def initialize(_app, client:, stub_responses:, stub_data_class:,
                     stub_error_classes:, params_class:, stubs:)
        @client = client
        @stub_responses = stub_responses
        @stub_data_class = stub_data_class
        @stub_error_classes = stub_error_classes
        @params_class = params_class
        @stubs = stubs
      end

      # @param input
      # @param context
      # @return [Output]
      def call(input, context)
        interceptor_error = context.interceptors.apply(
          hook: Interceptor::Hooks::MODIFY_BEFORE_TRANSMIT,
          input: input,
          context: context,
          output: nil,
          aggregate_errors: false
        )
        return Hearth::Output.new(error: interceptor_error) if interceptor_error

        interceptor_error = context.interceptors.apply(
          hook: Interceptor::Hooks::READ_BEFORE_TRANSMIT,
          input: input,
          context: context,
          output: nil,
          aggregate_errors: true
        )
        return Hearth::Output.new(error: interceptor_error) if interceptor_error

        output = Output.new
        if @stub_responses
          stub_response(input, context, output)
        else
          send_request(context, output)
        end

        interceptor_error = context.interceptors.apply(
          hook: Interceptor::Hooks::READ_AFTER_TRANSMIT,
          input: input,
          context: context,
          output: output,
          aggregate_errors: true
        )
        output.error = interceptor_error if interceptor_error

        output
      end

      private

      def stub_response(input, context, output)
        stub = @stubs.next(context.operation_name)
        apply_stub(stub, input, context, output)
        return unless context.response.body.respond_to?(:rewind)

        context.response.body.rewind
      end

      def send_request(context, output)
        @client.transmit(
          request: context.request,
          response: context.response,
          logger: context.logger
        )
      rescue Hearth::NetworkingError => e
        output.error = e
      end

      def apply_stub(stub, input, context, output)
        # require 'byebug'
        # byebug
        case stub
        when Proc
          stub = stub.call(input, context)
          apply_stub(stub, input, context, output) if stub
        when Exception, ApiError
          output.error = stub
        when Hash
          if stub.key?(:error)
            klass, params = stub[:error]
            error = @stub_error_classes.find do |stub_error_class|
              stub_error_class.error_class == klass
            end
            if error
              error.stub(
                context.response,
                stub: error.params_class.build(
                  params || {},
                  context: 'stub'
                )
              )
            else
              raise ArgumentError, 'Unsupported stub error class'
            end
          elsif stub.key?(:data)
            @stub_data_class.stub(
              context.response,
              stub: @params_class.build(
                stub[:data],
                context: 'stub'
              )
            )
          end
        when NilClass
          @stub_data_class.stub(
            context.response,
            stub: @params_class.build(
              @stub_data_class.default,
              context: 'stub'
            )
          )
        when Hearth::Structure
          @stub_data_class.stub(
            context.response,
            stub: stub
          )
        when Hearth::Response
          context.response.replace(stub)
        else
          raise ArgumentError, 'Unsupported stub type'
        end
      end
    end
  end
end
