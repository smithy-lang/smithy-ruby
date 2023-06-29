# frozen_string_literal: true

module Hearth
  # A list of plugins that can be applied to config. Plugins are callables
  # that take one argument (config) and are called during client initialization
  # or operation invocation to modify config.
  class PluginList
    def initialize(plugins = [])
      case plugins
      when PluginList
        @plugins = plugins.plugins
      else
        unless plugins.respond_to?(:each)
          raise ArgumentError, 'Plugins must be an enumerable'
        end

        @plugins = []
        plugins.each { |p| add(p) }
      end
    end

    def add(plugin)
      unless valid_plugin?(plugin)
        raise ArgumentError,
              'Plugin must be callable and take one argument (config)'
      end

      @plugins << plugin
    end

    alias << add

    def apply(config)
      @plugins.each { |p| p.call(config) }
    end

    def plugins
      @plugins.dup
    end

    private

    def valid_plugin?(plugin)
      case plugin
      when Proc
        plugin.arity == 1
      else
        plugin.respond_to?(:call) && plugin.method(:call).arity == 1
      end
    end
  end
end
