# frozen_string_literal: true

module Smithy
  module Model
    # @api private
    class Flattener
      def initialize(model)
        @model = model
      end

      def shape(id)
        shape = @model['shapes'][id]
        return shape unless shape['mixins']

        shape['mixins'].reverse_each do |mixin|
          mixin_shape = shape(mixin['target'])
          shape = deep_merge(mixin_shape, shape, exclude_traits(mixin_shape))
          apply_member_traits(id, shape)
          shape.delete('mixins')
        end

        shape
      end

      private

      def exclude_traits(shape)
        [
          'smithy.api#mixin',
          *shape.fetch('traits', {}).fetch('smithy.api#mixin', {}).fetch('localTraits', [])
        ]
      end

      def deep_merge(hash1, hash2, exclude_traits = [], context = nil)
        hash1 = hash1.dup
        if hash1['traits']
          hash1['traits'] = hash1['traits'].except(*exclude_traits)
          hash1.delete('traits') if hash1['traits'].empty?
        end
        deep_merge!(hash1, hash2, exclude_traits, context)
      end

      def deep_merge!(hash1, hash2, exclude_traits, context)
        hash1.merge!(hash2) do |key, v1, v2|
          if v1.is_a?(Hash) && v2.is_a?(Hash)
            deep_merge(v1, v2, exclude_traits, key)
          elsif v1.is_a?(Array) && v2.is_a?(Array) && context != 'traits'
            # Merge arrays, but only if the key is not a trait
            v1 + v2
          else
            v2
          end
        end
      end

      def apply_member_traits(id, shape)
        shape.fetch('members', []).each do |member_name, member_shape|
          member_id = "#{id}$#{member_name}"
          next unless @model['shapes'][member_id] && @model['shapes'][member_id]['type'] == 'apply'

          apply_shape = shape(member_id)
          member_keys = shape['members'][member_name].keys
          shape['members'][member_name] = deep_merge(member_shape, apply_shape).slice(*member_keys)
        end
      end
    end
  end
end
