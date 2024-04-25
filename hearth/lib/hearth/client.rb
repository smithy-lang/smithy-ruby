# frozen_string_literal: true

require_relative 'client_stubs'

module Hearth
  # Base Client class for all generated SDK clients.
  class Client
    include ClientStubs

    # Plugins applied to all instances of this client.
    # @return [Hearth::PluginList]
    def self.plugins
      @plugins ||= PluginList.new
    end

    def initialize(options, config_class)
      @config = initialize_config(options, config_class)
    end

    # @return config
    attr_reader :config

    private

    def initialize_config(options, config_class)
      client_interceptors = options.delete(:interceptors) || []
      config = config_class.new(**options)
      config.validate!
      self.class.plugins.each { |p| p.call(config) }
      config.plugins.each { |p| p.call(config) }
      config.interceptors.concat(client_interceptors)
      config.validate!
      config.freeze
    end

    def operation_config(options)
      return @config if options.empty?

      if options.include?(:stub_responses) || options.include?(:stubs)
        msg = 'Overriding stubs or stub_responses on ' \
              'operations is not allowed'
        raise ArgumentError, msg
      end

      operation_plugins = options.delete(:plugins)
      operation_interceptors = options.delete(:interceptors) || []
      config = @config.merge(options)
      config.validate!
      operation_plugins&.each { |p| p.call(config) }
      config.interceptors.concat(operation_interceptors)
      config.validate!
      config.freeze
    end

    def output_stream(options = {}, &block)
      return options.delete(:output_stream) if options[:output_stream]
      return Hearth::BlockIO.new(block) if block

      ::StringIO.new
    end
  end
end
