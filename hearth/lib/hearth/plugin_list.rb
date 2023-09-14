# frozen_string_literal: true

module Hearth
  # A list of plugins that can be applied to config. Plugins are callables
  # that take one argument (config) and are called during client initialization
  # or operation invocation to modify config.
  class PluginList
    include Enumerable

    # Initialize a PluginList.
    #
    # @param [Array] plugins ([]) A list of plugins to initialize with
    def initialize(plugins = [])
      unless plugins.respond_to?(:each)
        raise ArgumentError, 'Plugins must be an enumerable'
      end

      @plugins = []
      plugins.each { |p| add(p) }
    end

    # Add a plugin
    #
    # @param [Callable] plugin
    def add(plugin)
      unless valid_plugin?(plugin)
        raise ArgumentError,
              'Plugin must be callable and take one argument (config)'
      end

      @plugins << plugin
    end

    alias << add

    def each(&block)
      @plugins.each(&block)
    end

    private

    # plugins must be callable and take exactly 1 argument (config)
    def valid_plugin?(plugin)
      case plugin
      when Proc
        # the arity of a proc.method(:call) is -1, need to special case
        plugin.arity == 1
      else
        plugin.respond_to?(:call) && plugin.method(:call).arity == 1
      end
    end
  end
end
