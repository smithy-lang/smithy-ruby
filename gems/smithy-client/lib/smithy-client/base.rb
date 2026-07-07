# frozen_string_literal: true

module Smithy
  module Client
    # Base class for all service clients.
    class Base
      include HandlerBuilder

      def initialize(plugins, options)
        @config = build_config(plugins, options)
        @handlers = build_handler_list(plugins)
        after_initialize(plugins)
      end

      # @return [Struct]
      attr_reader :config

      # @return [HandlerList]
      attr_reader :handlers

      # Builds and returns a {Request} for the named operation. The request will not have been sent.
      # @param [Symbol] operation_name
      # @return [Request]
      def build_request(operation_name, params = {})
        Request.new(
          handlers: @handlers.for(operation_name),
          context: context_for(operation_name, params)
        )
      end

      # @return [Array<Symbol>] Returns a list of valid request operation
      #  names. These are valid arguments to {#build_input} and are also
      #  valid methods.
      def operation_names
        self.class.service.operation_names
      end

      # @api private
      def inspect
        "#<#{self.class.name || 'Smithy::Client::Base'}>"
      end

      private

      # Constructs a {Configuration} object and gives each plugin the
      #  opportunity to register options with default values.
      def build_config(plugins, options)
        config = Configuration.new
        config.add_option(:service)
        config.add_option(:plugins)
        plugins.each do |plugin|
          plugin.add_options(config) if plugin.respond_to?(:add_options)
        end
        config.build!(options.merge(service: self.class.service))
      end

      # Gives each plugin the opportunity to register handlers for this client.
      def build_handler_list(plugins)
        plugins.each_with_object(HandlerList.new) do |plugin, handlers|
          plugin.add_handlers(handlers, @config) if plugin.respond_to?(:add_handlers)
        end
      end

      # Gives each plugin the opportunity to modify this client.
      def after_initialize(plugins)
        plugins.reverse.each do |plugin|
          plugin.after_initialize(self) if plugin.respond_to?(:after_initialize)
        end
      end

      # @return [HandlerContext]
      def context_for(operation_name, params)
        HandlerContext.new(
          operation_name: operation_name,
          operation: config.service.operation(operation_name),
          client: self,
          params: params,
          config: config
        )
      end

      def waiter(waiter_name, options = {})
        waiter_class = waiters[waiter_name]
        raise Waiters::NoSuchWaiterError.new(waiter_name, waiters.keys) unless waiter_class

        waiter_class.new(options.merge(client: self))
      end

      class << self
        def new(options = {})
          options = options.dup
          plugins = build_plugins(options[:plugins])
          before_initialize(plugins, options)
          client = allocate
          client.send(:initialize, plugins, options)
          client
        end

        # Registers a plugin with this client.
        #
        # @example Register a plugin
        #
        #   ClientClass.add_plugin(PluginClass)
        #
        # @example Register a plugin with an object
        #
        #   plugin = MyPluginClass.new(options)
        #   ClientClass.add_plugin(plugin)
        #
        # @param [Class, Symbol, String, Object] plugin
        # @see .clear_plugins
        # @see .set_plugins
        # @see .remove_plugin
        # @see .plugins
        # @return [void]
        def add_plugin(plugin)
          @plugins.add(plugin)
        end

        # @see .clear_plugins
        # @see .set_plugins
        # @see .add_plugin
        # @see .plugins
        # @return [void]
        def remove_plugin(plugin)
          @plugins.remove(plugin)
        end

        # @see .set_plugins
        # @see .add_plugin
        # @see .remove_plugin
        # @see .plugins
        # @return [void]
        def clear_plugins
          @plugins.set([])
        end

        # @param [Array<Plugin>] plugins
        # @see .clear_plugins
        # @see .add_plugin
        # @see .remove_plugin
        # @see .plugins
        # @return [void]
        def plugins=(plugins)
          @plugins.set(plugins)
        end

        # Returns the list of registered plugins for this Client. Plugins are
        #  inherited from the client super class when the client is defined.
        # @see .clear_plugins
        # @see .set_plugins
        # @see .add_plugin
        # @see .remove_plugin
        # @return [Array<Plugin>]
        def plugins
          Array(@plugins).freeze
        end

        # @return [Schema::Shapes::ServiceShape]
        def service
          @service ||= Schema::Shapes::ServiceShape.new
        end

        # @param [ServiceShape] service
        attr_writer :service

        # @option options [ServiceShape] :service (ServiceShape.new)
        # @option options [Array<Plugin>] :plugins ([]) A list of plugins to
        #  add to the client class created.
        # @return [Class<Client::Base>]
        def define(options = {})
          subclass = Class.new(self)
          subclass.service = options[:service] || service
          Array(options[:plugins]).each do |plugin|
            subclass.add_plugin(plugin)
          end
          subclass
        end
        alias extend define

        private

        def build_plugins(instance_plugins = nil)
          list = PluginList.new(@plugins)
          Array(instance_plugins).each { |plugin| list.add(plugin) }
          list.map { |plugin| plugin.is_a?(Class) ? plugin.new : plugin }.freeze
        end

        def before_initialize(plugins, options)
          plugins.each do |plugin|
            plugin.before_initialize(self, options) if plugin.respond_to?(:before_initialize)
          end
        end

        def inherited(subclass)
          super
          subclass.instance_variable_set('@plugins', PluginList.new)
        end
      end
    end
  end
end
