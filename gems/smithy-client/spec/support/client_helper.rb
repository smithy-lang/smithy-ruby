# frozen_string_literal: true

require_relative '../../../smithy-schema/spec/support/schema_helper'

module ClientHelper
  class << self
    def sample_service(options = {})
      module_name = options[:module_name] || next_sample_module_name
      model = options[:model] ||= model(options)
      plan = create_plan(module_name, model, options)
      source = Smithy.source(plan)
      Object.module_eval(source)
      Object.const_get(module_name)
    rescue LoadError => e
      puts "Error evaluating source:\n#{source}"
      raise e
    end

    private

    def create_plan(module_name, model, options)
      plan_options = {
        module_name: module_name,
        gem_version: options[:gem_version] || '0.1.0'
      }
      Smithy::Plan.new(model, :client, plan_options)
    end

    def model(options)
      {
        'smithy' => smithy(options),
        'shapes' => shapes(options)
      }
    end

    def smithy(options)
      options.delete(:smithy) || '2.0'
    end

    def shapes(options)
      options.delete(:shapes) || SchemaHelper.sample_shapes
    end

    def next_sample_module_name
      @sample_service_count ||= 0
      @sample_service_count += 1
      "SampleClient#{@sample_service_count}"
    end
  end
end
