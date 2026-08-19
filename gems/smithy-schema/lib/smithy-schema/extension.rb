# frozen_string_literal: true

module Smithy
  module Schema
    # Lazily-built, cached lookup tables on shapes. Protocol-agnostic tables live
    # here; protocol-specific ones live in their codec gems.
    # @api private
    module Extension
      class << self
        # wire (model_name) => [member_name, member_shape]
        def member_index(shape)
          shape[:member_index] ||= build_member_index(shape)
        end

        private

        def build_member_index(shape)
          index = {}
          shape.members.each do |name, member|
            wire_name = member.model_name
            next unless wire_name

            index[wire_name] = [name, member]
          end
          index.freeze
        end
      end
    end
  end
end
