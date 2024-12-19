# frozen_string_literal: true

module Smithy
  # The Plan class is a simple data structure that holds the model, type, and options for a generator.
  class Plan
    # @param [Hash] model The API model as a JSON hash.
    # @param [Symbol] type The type of code to generate, either :client, :server, or :types.
    # @param [Hash] options The options passed to the generator.
    def initialize(model, type, options = {})
      @type = type
      @options = options

      Welds.load!(self)
      @welds = Welds.for(model)
      Polishes.load!(self)
      @polishes = Polishes.for(model)

      @welds.each { |weld| weld.preprocess(model) }
      @model = Vise::Model.new(model)

      initialize_endpoint_bindings
    end

    # @return [Vise::Model] The API model wrapped by Vise.
    attr_reader :model

    # @return [Symbol] The type of code to generate.
    attr_reader :type

    # @return [Hash] The options passed to the generator.
    attr_reader :options

    # @return [Array<Weld>] The welds that apply to this plan.
    attr_reader :welds

    # @return [Array<Polish>] The polishes that apply to this plan.
    attr_reader :polishes

    # @return [Hash[String, BuiltInBinding]] Array of all registered builtins
    attr_reader :built_in_bindings

    # @return [Hash[String, FunctionBinding]] Array of all registered functions
    attr_reader :function_bindings

    private

    def initialize_endpoint_bindings
      # TODO: We need to validate somewhere that all of the builtin's used in a ruleset have valid bindings
      @built_in_bindings = @welds.map(&:built_in_bindings).flatten.compact.to_h { |b| [b.id, b] }
      @function_bindings = @welds.map(&:function_bindings).flatten.compact.to_h { |b| [b.id, b] }
    end
  end
end
