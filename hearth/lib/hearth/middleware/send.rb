# frozen_string_literal: true

module Hearth
  module Middleware
    # A middleware used to send the request.
    # @api private
    class Send
      # @param [Class] _app The next middleware in the stack.
      # @param [Boolean] stub_responses If true, a request is not sent and a
      #   stubbed response is returned.
      # @param [Class] stub_class A stub object that is responsible for creating
      #   a stubbed response. It must respond to #stub and take the response
      #   and stub data as arguments.
      # @param [Class] params_class A Params class responsible for
      #   converting a ruby hash into the operation's modeled output Type.
      # @param [Stubs] stubs A {Hearth::Stubbing:Stubs} object containing
      #   stubbed data for any given operation.
      def initialize(_app, client:, stub_responses:,
                     stub_class:, params_class:, stubs:)
        @client = client
        @stub_responses = stub_responses
        @stub_class = stub_class
        @params_class = params_class
        @stubs = stubs
      end

      # @param input
      # @param context
      # @return [Output]
      # rubocop:disable Metrics/MethodLength
      def call(input, context)
        output = Output.new
        if @stub_responses
          stub = @stubs.next(context.operation_name)
          apply_stub(stub, input, context, output)
          if context.response.body.respond_to?(:rewind)
            context.response.body.rewind
          end
        else
          resp_or_error = @client.transmit(
            request: context.request,
            response: context.response,
            logger: context.logger
          )
          if resp_or_error.is_a?(Hearth::NetworkingError)
            output.error = resp_or_error
          end
        end
        output
      end

      private

      def apply_stub(stub, input, context, output)
        case stub
        when Proc
          stub = stub.call(input, context)
          apply_stub(stub, input, context, output) if stub
        when Exception
          output.error = stub
        when Class
          output.error = stub.new
        when Hash
          @stub_class.stub(
            context.response,
            stub: @params_class.build(
              stub,
              context: 'stub'
            )
          )
        when NilClass
          @stub_class.stub(
            context.response,
            stub: @params_class.build(
              @stub_class.default,
              context: 'stub'
            )
          )
        else
          raise ArgumentError, 'Unsupported stub type'
        end
      end
      # rubocop:enable Metrics/MethodLength
    end
  end
end
