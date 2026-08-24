# frozen_string_literal: true

module Smithy
  module Json
    # Lookup helpers for JSON serde using the Smithy @jsonName trait.
    # @api private
    module Extension
      class << self
        # Smithy @jsonName or modeled member name => [ruby_member_name, member_shape]
        def member_index(shape)
          shape[:json_index] ||= build_member_index(shape)
        end

        # Returns the JSON wire name, preferring the Smithy @jsonName trait.
        def wire_name(member)
          member.traits['smithy.api#jsonName'] || member.name
        end

        private

        def build_member_index(shape)
          index = {}
          shape.members.each do |name, member|
            next unless member.name

            index[wire_name(member)] = [name, member]
          end
          index.freeze
        end
      end
    end
  end
end
