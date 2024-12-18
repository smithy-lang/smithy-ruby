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
    end

    # @return [Vise::Model] The API model wrapped by Vise.
    attr_reader :model

    # @return [Symbol] The type of code to generate.
    attr_reader :type

    # @return [Hash] The options passed to the generator.
    attr_reader :options

    # @return [Array<Weld>] The welds that apply to this model.
    attr_reader :welds

    # @return [Array<Polish>] The polishes that apply to this model.
    attr_reader :polishes
  end
end
