# frozen_string_literal: true

require 'active_support/core_ext/object/deep_dup'

module Smithy
  module Welds
    # Creates synthetic input and output shapes for operations that do not have them.
    class SyntheticInputOutput < Weld
      def pre_process(model)
        say_status :modify, 'Creating synthetic input and output shapes', :yellow unless @plan.quiet
        create_synthetic_input_output_shapes(model)
      end

      private

      def create_synthetic_input_output_shapes(model)
        Model::ServiceIndex.new(model).operations_for(@plan.service).each do |operation_id, operation|
          create_synthetic_input_shape(model, operation_id, operation) if operation['input']
          create_synthetic_output_shape(model, operation_id, operation) if operation['output']
        end
      end

      def create_synthetic_input_shape(model, operation_id, operation)
        input_target = operation['input']['target']
        target = Model.shape(model, input_target)
        return if target.fetch('traits', {}).include?('smithy.api#input') || input_target == 'smithy.api#Unit'

        input_target = new_shape_id(model, operation_id, 'Input')
        operation['input']['target'] = input_target
        input_shape = target.deep_dup
        model['shapes'][input_target] = input_shape
        input_shape['traits'] = input_shape.fetch('traits', {}).merge({ 'smithy.api#input' => {} })
      end

      def create_synthetic_output_shape(model, operation_id, operation)
        output_target = operation['output']['target']
        target = Model.shape(model, output_target)
        return if target.fetch('traits', {}).include?('smithy.api#output') || output_target == 'smithy.api#Unit'

        output_target = new_shape_id(model, operation_id, 'Output')
        operation['output']['target'] = output_target
        output_shape = target.deep_dup
        model['shapes'][output_target] = output_shape
        output_shape['traits'] = output_shape.fetch('traits', {}).merge({ 'smithy.api#output' => {} })
      end

      def new_shape_id(model, operation_id, suffix)
        namespace = Model::Shape.namespace(operation_id)
        operation_name = Model::Shape.name(operation_id)
        id = "#{namespace}##{operation_name}#{suffix}"
        return id unless model['shapes'].key?(id)

        id = "#{namespace}##{operation_name}Operation#{suffix}"
        return id unless model['shapes'].key?(id)

        raise "unable to generate a unique synthetic #{suffix} shape ID for #{operation_id}"
      end
    end
  end
end
