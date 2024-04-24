# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

require 'stringio'

module DefaultValues
  class Client
    include Hearth::ClientStubs

    # @api private
    @plugins = Hearth::PluginList.new

    # @return [Hearth::PluginList]
    def self.plugins
      @plugins
    end

    # @param [Hash] options
    #   Options used to construct an instance of {Config}
    def initialize(options = {})
      @config = initialize_config(options)
      @stubs = Hearth::Stubs.new
    end

    # @return [Config] config
    attr_reader :config

    # @param [Hash | Types::GetThingInput] params
    #   Request parameters for this operation.
    #   See {Types::GetThingInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.get_thing()
    # @example Response structure
    #   resp.data #=> Types::GetThingOutput
    def get_thing(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::GetThingInput.build(params, context: 'params')
      stack = DefaultValues::Middleware::GetThing.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :get_thing,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#get_thing] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#get_thing] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#get_thing] #{output.data}")
      output
    end

    private

    def initialize_config(options)
      client_interceptors = options.delete(:interceptors)
      config = Config.new(**options)
      config.validate!
      Client.plugins.each { |p| p.call(config) }
      config.plugins.each { |p| p.call(config) }
      config.interceptors.concat(client_interceptors) if client_interceptors
      config.validate!
      config.freeze
    end

    def operation_config(options)
      return @config if options.empty?

      operation_plugins = options.delete(:plugins)
      operation_interceptors = options.delete(:interceptors)
      config = @config.merge(options)
      config.validate!
      operation_plugins.each { |p| p.call(config) } if operation_plugins
      config.interceptors.concat(operation_interceptors) if operation_interceptors
      config.validate!
      config.freeze
    end
  end
end
