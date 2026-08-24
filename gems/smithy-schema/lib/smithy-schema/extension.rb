# frozen_string_literal: true

module Smithy
  module Schema
    # Lookup helpers for protocol-agnostic serde using modeled member names.
    #
    # Raw Smithy trait data remains on +shape.traits+ and +member.traits+ with
    # string keys. This module only provides generic resolved lookup helpers and
    # memoizes shape-level indexes in metadata when that meaningfully avoids
    # rebuilding them.
    # @api private
    module Extension
      extend ExtensionHelpers

      class << self
        # Returns the member lookup index cached on the shape as
        # +shape[:member_index]+ or +shape[:json_index]+.
        #
        # The index maps:
        # - resolved wire name
        # - to [ruby_member_name, member_shape]
        def member_index(shape, json_name: false)
          if json_name
            shape[:json_index] ||= build_member_index(shape, json_name: true)
          else
            shape[:member_index] ||= build_member_index(shape)
          end
        end

        # Returns the resolved member wire name for schema lookup.
        def wire_name(member, json_name: false)
          return member.name unless json_name

          cached = member[:json_name]
          return cached unless cached.nil?

          member[:json_name] = member.traits['smithy.api#jsonName'] || member.name
        end

        private

        def build_member_index(shape, json_name: false)
          index = {}
          shape.members.each do |name, member|
            wire_name = wire_name(member, json_name: json_name)
            next unless wire_name

            index[wire_name] = [name, member]
          end
          index.freeze
        end
      end
    end
  end
end
