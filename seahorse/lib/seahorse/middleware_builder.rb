# frozen_string_literal: true

module Seahorse

  # A utility class for registering middleware for a request.
  # You register middleware handlers to execute relative to
  # Middleware classes.  You can register middleware
  # before/after/around any middleware class in the stack.
  # There are also convenience methods
  # (eg: before_build, after_parse, ect)
  # defined for all of the key request lifecycle events:
  #
  # * validate
  # * host_prefix
  # * build
  # * send
  # * parse
  # * retry
  #
  # You can register request handlers that invoke before, after,
  # or around each lifecycle events. These handlers are
  # request, response, or around handlers.
  #
  # All before/after/around methods are defined on the class
  # and instance and are chainable:
  #
  #    MiddlewareBuilder.before_send(my_request_handler)
  #       .after_parse(my_response_handler)
  #
  # ## Request Handlers
  #
  # A request handler is invoked before the request is sent.
  #
  #    # invoked after a request has been built, but before it has
  #    # been signed/authorized
  #    middleware.before_build do |input, context|
  #      # use input, inspect or modify the request
  #      # context.request
  #    end
  #
  # ## Response Handlers
  #
  # A response handler is invoked after the HTTP request has been sent
  # and a HTTP response has been received.
  #
  #    # invoked after the HTTP response has been parsed
  #    middleware.after_parse do |input, output, response|
  #      # inspect or modify the output or response
  #      # output.data
  #      # output.error
  #      # context.response
  #    end
  #
  # ## Around Handlers
  #
  # Around handlers see a request before it has been sent along
  # with the response returned. Around handlers must invoke `#call`
  # method of the next middleware in the stack. Around handlers
  # must also return the response returned from the next middleware.
  #
  #     # invoke before the request  has been sent, receives the
  #     # response from the send middleware
  #     middleware.around_send do |app, input, context|
  #
  #       # this code is invoked before the request is sent
  #       # ...
  #
  #       # around handlers MUST call the next middleware in the stack
  #       output = app.call(input, context)
  #
  #       # this code is invoked after the response has been received
  #       # ...
  #
  #       # around handlers must return the response down the stack
  #       output
  #     end
  #
  class MiddlewareBuilder

    # @private
    BOTH = 'expected a handler or a Proc, got both'

    # @private
    NEITHER = 'expected a handler or a Proc, got neither'

    # @private
    TOO_MANY = 'wrong number of arguments (given %<count>d, expected 0 or 1)'

    # @private
    CALLABLE = 'expected handler to respond to #call'

    # @param [Proc, MiddlewareBuilder] middleware
    #
    #   If `middleware` is another {MiddlewareBuilder} instance, then
    #   the middleware handlers are copied.
    #
    def initialize(middleware = nil)
      @middleware = []
      case middleware
      when MiddlewareBuilder then @middleware.concat(middleware.to_a)
      when nil
      else
        raise ArgumentError, 'expected :middleware to be a' \
          "Seahorse::MiddlewareBuilder, got #{middleware.class}"
      end
    end

    # @param [MiddlewareStack] middleware_stack
    def apply(middleware_stack)
      @middleware.each do |handler|
        # TODO: There needs to be a better way to do this with Ruby 2.7/3 kwargs
        middleware_stack.send(handler[0], handler[1], handler[2], **handler[3])
      end
    end

    def before(klass, *args, &block)
      @middleware << [
        :use_before,
        klass,
        Middleware::RequestHandler,
        handler: handler_or_proc!(args, &block)
      ]
      self
    end

    def after(klass, *args, &block)
      @middleware << [
        :use_before,
        klass,
        Middleware::ResponseHandler,
        handler: handler_or_proc!(args, &block)
      ]
      self
    end

    def around(klass, *args, &block)
      @middleware << [
        :use_before,
        klass,
        Middleware::AroundHandler,
        handler: handler_or_proc!(args, &block)
      ]
      self
    end

    # Define convenience methods for chaining
    class << self
      def before(klass, *args, &block)
        MiddlewareBuilder.new.before(klass, *args, &block)
      end

      def after(klass, *args, &block)
        MiddlewareBuilder.new.after(klass, *args, &block)
      end

      def around(klass, *args, &block)
        MiddlewareBuilder.new.around(klass, *args, &block)
      end
    end

    # define convenience methods for standard middleware classes
    # these define methods and class methods for before,after,around
    # eg: before_build, after_build, around_build.
    STANDARD_MIDDLEWARE = [Seahorse::Middleware::Validate,
                           Seahorse::Middleware::HostPrefix,
                           Seahorse::Middleware::Build,
                           Seahorse::Middleware::Send,
                           Seahorse::Middleware::Retry,
                           Seahorse::Middleware::Parse].freeze
    STANDARD_MIDDLEWARE.each do |klass|
      simple_step_name = klass.to_s.split('::').last.downcase
      %w[before after around].each do |method|
        method_name = "#{method}_#{simple_step_name}"
        define_method(method_name) do |*args, &block|
          return send(method, klass, *args, &block)
        end

        define_singleton_method(method_name) do |*args, &block|
          return send(method, klass, *args, &block)
        end
      end
    end

    def to_a
      @middleware
    end

    private

    def handler_or_proc!(args, &block)
      raise ArgumentError, BOTH if args.size > 0 && block
      raise ArgumentError, NEITHER if args.empty? && block.nil?
      raise ArgumentError, format(TOO_MANY, count: args.size) if args.size > 1
      callable = args.first || Proc.new(&block)
      raise ArgumentError, CALLABLE unless callable.respond_to?(:call)
      callable
    end

  end
end