# frozen_string_literal: true

require_relative 'client_stubs'

module Hearth
  # Base Client class for all generated SDK clients.
  class ClientBase
    include ClientStubs

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
      operation_plugins&.each { |p| p.call(config) }
      if operation_interceptors
        config.interceptors.concat(operation_interceptors)
      end
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
