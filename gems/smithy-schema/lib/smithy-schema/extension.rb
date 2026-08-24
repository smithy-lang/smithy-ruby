# frozen_string_literal: true

module Smithy
  module Schema
    # Lookup helpers for protocol-agnostic serde using modeled member names.
    #
    # Raw Smithy trait data remains on +shape.traits+ and +member.traits+ with
    # string keys. This module only provides generic modeled-name lookup
    # helpers and memoizes shape-level indexes in metadata when that
    # meaningfully avoids rebuilding them.
    # @api private
    module Extension
      extend ExtensionHelpers

      class << self
        # Returns the modeled member lookup index cached on the shape as
        # +shape[:member_index]+.
        #
        # The index maps:
        # - modeled member name
        # - to [ruby_member_name, member_shape]
        def member_index(shape)
          shape[:member_index] ||= build_member_index(shape)
        end

        # Returns the modeled member name for schema lookup.
        def wire_name(member)
          member.name
        end

        private

        def build_member_index(shape)
          index = {}
          shape.members.each do |name, member|
            wire_name = wire_name(member)
            next unless wire_name

            index[wire_name] = [name, member]
          end
          index.freeze
        end
      end
    end
  end
end
