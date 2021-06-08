# frozen_string_literal: true

module Seahorse
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
      # @param [Stubs] stubs A {Seahorse::Stubbing:Stubs} object containing
      #   stubbed data for any given operation.
      def initialize(_app, client:, stub_responses:, stub_class:, stubs:)
        @client = client
        @stub_responses = stub_responses
        @stub_class = stub_class
        @stubs = stubs
      end

      # @param _input
      # @param context
      # @return [Output]
      def call(_input, context)
        if @stub_responses
          stub = @stubs.next(context.operation_name)
          output = Output.new
          apply_stub(stub, context, output)
          output
        else
          @client.transmit(
            request: context.request,
            response: context.response
          )
          Output.new
        end
      end

      private

      def apply_stub(stub, context, output)
        case stub
        when Proc
          stub = stub.call(context)
          apply_stub(stub, context, output) if stub
        when Exception
          output.error = stub
        when Class
          output.error = stub.new
        when Hash
          @stub_class.stub(context.response, stub: stub)
        when NilClass
          @stub_class.stub(context.response, stub: @stub_class.default)
        else
          raise ArgumentError, 'Unsupported stub type'
        end
      end
    end
  end
end
