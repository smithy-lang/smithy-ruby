# frozen_string_literal: true

module Smithy
  # Base class that all welds must inherit from. Includes hooks for code generation.
  class Weld
    include Thor::Base
    include Thor::Actions

    # @param [Plan] plan The plan that is being executed.
    def initialize(plan)
      @plan = plan
      # Necessary for Thor::Base and Thor::Actions
      self.options = { force: true, quiet: plan.quiet }
      self.destination_root = plan.destination_root
      shell.base = self
    end

    # Called to determine if the weld should be applied for this model.
    # @param [Hash] service Service shape
    # @return [Boolean] (true) True if the weld should be applied, false otherwise.
    def for?(service) # rubocop:disable Lint/UnusedMethodArgument
      true
    end

    # Pre-process the model. Called before the model is loaded.
    # @param [Hash] model
    def pre_process(model)
      model
    end

    # Post-process the artifacts after they are generated.
    # @param [Array<String>] artifacts The files that were generated.
    def post_process(artifacts)
      artifacts
    end

    # Called when constructing the module and gemspec. Any dependencies defined
    # here will be merged with other dependencies. The key is the name of the
    # dependency and the value is the version constraint.
    def add_dependencies
      {}
    end

    # Called when constructing the module and gemspec. Any dependencies defined
    # here will be removed from the module and gemspec. Each element in the
    # array is the name of the dependency.
    def remove_dependencies
      []
    end

    # Called when constructing endpoint parameters. Any bindings defined here will
    # be merged with other built-in bindings. The key is the name of the binding, and
    # the value is the binding definition, which is a hash with keys :render_build and
    # :render_test_set. :render_build is a proc that takes the plan as an argument and returns
    # a string that is rendered in the endpoint parameters `.create` method. :render_test_set
    # is a proc that takes the plan and the value of the built-in parameter as arguments,
    # and returns a hash of parameters to be added to the test set.
    # @return [Hash<String, Hash>] endpoint built in bindings for use in endpoint rules.
    def endpoint_built_in_bindings
      {}
    end

    # Called when constructing the endpoint provider. Any bindings defined here will
    # be merged with other function bindings. The key is the name of the binding, and
    # the value is the function to call.
    # @return [Hash<String, String>] endpoint function bindings for use in endpoint rules.
    def endpoint_function_bindings
      {}
    end

    # Called when constructing the endpoints plugin. Any bindings defined here will
    # be merged with other endpoint auth scheme bindings. The key is the name of the
    # binding for the endpoints auth, and the value is the absolute shape id of the
    # auth scheme trait.
    # @return [Hash<String, String>] endpoint auth scheme bindings for use in endpoint rules
    def endpoint_auth_scheme_bindings
      {}
    end

    # Called when constructing the client. Any plugins defined here will be merged
    # with other plugins. The key is the fully qualified class name of the plugin,
    # and the value is a hash with any of the following keys:
    # * :source - the source code of the plugin
    # * :require_path - the path to require the plugin from the client
    # * :require_relative - true if the path should be required relative to the client
    # @return [Hash<String, Hash>] a mapping of fully qualified class names as the
    #  key, and the plugin
    def add_plugins
      {}
    end

    # Called when constructing the client. Any plugins defined here will be removed
    # from the client. Each element in the array is the fully qualified class name.
    def remove_plugins
      []
    end

    # Called when constructing the client. Any protocols defined here will be
    # merged into the client's protocol registry. The key is the protocol name
    # (a Symbol) and the value is the fully qualified protocol class.
    # @return [Hash<Symbol, Class>] a mapping of protocol names to protocol classes.
    def add_protocols
      {}
    end

    # Called when creating the auth resolver and auth schemes. The value is the
    # absolute shape id of the auth scheme trait.
    def add_auth_schemes
      []
    end

    # Called when creating the auth resolver and auth schemes. The value is the
    # absolute shape id of the auth scheme trait.
    def remove_auth_schemes
      []
    end

    # Called when generating protocol tests. The key should be the same as the vendor params shape
    # in a protocol test, and the value should be a class that responds to one of the following methods:
    # * error_expect_code(params) - returns a string that is rendered inside a rescue block (with error rescued as `e`).
    # Protocol tests are run with RSpec and expectations should be used.
    def protocol_test_vendor_code
      {}
    end
  end
end
