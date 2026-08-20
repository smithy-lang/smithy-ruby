# frozen_string_literal: true

module Smithy
  module Schema
    # Lookup helpers for protocol-agnostic serde using modeled member names.
    # @api private
    module Extension
      class << self
        # Modeled member name => [ruby_member_name, member_shape]
        def member_index(shape)
          shape[:member_index] ||= build_member_index(shape)
        end

        # Returns the modeled member name for generic schema lookup.
        def wire_name(member)
          member.model_name
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
