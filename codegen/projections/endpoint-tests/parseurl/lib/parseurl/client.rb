# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module ParseUrl
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
