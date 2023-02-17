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
      def call(input, context)

        # modify_before_transmit hook
        # exception behavior - exceptions set to output.error and control
        # bubbles up to modifyBeforeAttemptCompletion
        context.interceptors.reverse.each do |i|
          if i.respond_to?(:modify_before_transmit)
            begin
              i.modify_before_transmit(context.interceptor_context(input, nil))
            rescue StandardError => e
              return Hearth::Output.new(error: e)
            end
          end
        end

        # read_before_transmit hook
        # exception behavior - exceptions set to output.error and control
        # bubbles up to modifyBeforeAttemptCompletion
        context.interceptors.reverse.each do |i|
          if i.respond_to?(:read_before_transmit)
            begin
              i.read_before_transmit(context.interceptor_context(input, nil))
            rescue StandardError => e
              return Hearth::Output.new(error: e)
            end
          end
        end

        if @stub_responses
          stub = @stubs.next(context.operation_name)
          output = Output.new
          apply_stub(stub, input, context, output)
        else
          @client.transmit(
            request: context.request,
            response: context.response
          )
          output = Output.new
        end

        # read_after_transmit hook
        # exception behavior - exceptions set to output.error and control
        # bubbles up to modifyBeforeAttemptCompletion
        context.interceptors.reverse.each do |i|
          if i.respond_to?(:read_after_transmit)
            begin
              i.read_after_transmit(context.interceptor_context(input, output))
            rescue StandardError => e
              return Hearth::Output.new(error: e)
            end
          end
        end

        output
      end

      private

      # rubocop:disable Metrics/MethodLength
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
