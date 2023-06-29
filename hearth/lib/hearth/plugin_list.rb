module Hearth
  class PluginList

    def initialize(plugins = [])
      unless plugins.respond_to?(:each)
        raise ArgumentError, 'Plugins must be an enumerable'
      end
      @plugins = []
      plugins.each { |p| add(p) }
    end

    def add(plugin)
      unless valid_plugin?(plugin)
        raise ArgumentError,
              'Plugin must be callable and take one argument (config)'
      end
      @plugins << plugin
    end

    def apply(config)
      @plugins.each { |p| p.call(config) }
    end

    alias_method :<<, :add

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
