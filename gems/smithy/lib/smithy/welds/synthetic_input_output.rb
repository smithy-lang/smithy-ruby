# frozen_string_literal: true

module Smithy
  module Welds
    # Creates synthetic input and output shapes for operations that do not have them.
    class SyntheticInputOutput < Weld
      def pre_process(model)
        say_status :insert, 'Creating synthetic input and output shapes', @plan.quiet
        create_synthetic_input_output_shapes(model)
      end

      private

      def create_synthetic_input_output_shapes(model)
        operations = Model::ServiceIndex.new(model).operations_for(@plan.service)
        operations.each do |operation_id, operation|
          create_synthetic_input_shape(model, operation_id, operation) if operation['input']
          create_synthetic_output_shape(model, operation_id, operation) if operation['output']
        end
      end

      def create_synthetic_input_shape(model, operation_id, operation)
        input_target = operation['input']['target']
        target = Model.shape(model, input_target)
        return if target.fetch('traits', {}).include?('smithy.api#input') || input_target == 'smithy.api#Unit'

        input_shape = {
          'type' => 'structure',
          'traits' => target.fetch('traits', {}).merge({ 'smithy.api#input' => {} }),
          'members' => target.fetch('members', {}).merge({})
        }
        input_target = "#{Model::Shape.namespace(operation_id)}##{Model::Shape.name(operation_id)}Input"
        model['shapes'][input_target] = input_shape
        operation['input']['target'] = input_target
      end

      def create_synthetic_output_shape(model, operation_id, operation)
        output_target = operation['output']['target']
        target = Model.shape(model, output_target)
        return if target.fetch('traits', {}).include?('smithy.api#output') || output_target == 'smithy.api#Unit'

        output_shape = {
          'type' => 'structure',
          'traits' => target.fetch('traits', {}).merge({ 'smithy.api#output' => {} }),
          'members' => target.fetch('members', {}).merge({})
        }
        output_target = "#{Model::Shape.namespace(operation_id)}##{Model::Shape.name(operation_id)}Output"
        model['shapes'][output_target] = output_shape
        operation['output']['target'] = output_target
      end
    end
  end
end
