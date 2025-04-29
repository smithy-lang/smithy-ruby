# frozen_string_literal: true

module Smithy
  module Model
    # @api private
    class YARD
      class << self
        # rubocop:disable Metrics/CyclomaticComplexity
        def type(model, id, shape)
          case shape['type']
          when 'blob', 'string', 'enum' then 'String'
          when 'boolean' then 'Boolean'
          when 'byte', 'short', 'integer', 'long', 'intEnum' then 'Integer'
          when 'float', 'double' then 'Float'
          when 'timestamp' then 'Time'
          when 'document' then 'JSON'
          when 'list'
            list_type(model, shape)
          when 'map'
            map_type(model, shape)
          when 'structure', 'union'
            structure_type(id)
          else
            'Object'
          end
        end
        # rubocop:enable Metrics/CyclomaticComplexity

        private

        def structure_type(id)
          if id == 'smithy.api#Unit'
            'Smithy::Schema::EmptyStructure'
          else
            "Types::#{Model::Shape.name(id)}"
          end
        end

        def map_type(model, shape)
          key_target = Model.shape(model, shape['key']['target'])
          value_target = Model.shape(model, shape['value']['target'])
          key_type = type(model, shape['key']['target'], key_target)
          value_type = type(model, shape['value']['target'], value_target)
          "Hash<#{key_type}, #{value_type}>"
        end

        def list_type(model, shape)
          member_target = Model.shape(model, shape['member']['target'])
          "Array<#{type(model, shape['member']['target'], member_target)}>"
        end
      end
    end
  end
end
