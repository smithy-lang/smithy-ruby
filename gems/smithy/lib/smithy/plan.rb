# frozen_string_literal: true

module Smithy
  # The Plan class is a simple data structure that holds the model, type, and options for a generator.
  class Plan
    # @param model [Hash] The API model as a JSON hash.
    # @param type [Symbol] The type of code to generate, either :client, :server, or :types.
    # @param options [Hash] The options passed to the generator.
    def initialize(model, type, options = {})
      @model = Vise::Model.new(model)
      @type = type
      @options = options
      # TODO: Where should this happen.  In old V4, these were part of generation context
      # build maps of id to binding for all available endpoint bindings
      @built_in_bindings = Smithy::Weld.descendants.map { |w| w.built_in_bindings }.flatten.compact.map { |b| [b.id, b] }.to_h
      @function_bindings = Smithy::Weld.descendants.map { |w| w.function_bindings }.flatten.compact.map { |b| [b.id, b] }.to_h
    end

    # @return [Hash] The API model as a JSON hash.
    attr_reader :model

    # @return [Symbol] The type of code to generate.
    attr_reader :type

    # @return [Hash] The options passed to the generator.
    attr_reader :options

    # @return [Hash[String, BuiltInBinding]] Array of all registered builtins
    attr_reader :built_in_bindings

    # @return [Hash[String, FunctionBinding]] Array of all registered functions
    attr_reader :function_bindings
  end
end
