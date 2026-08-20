# frozen_string_literal: true

module Smithy
  module Json
    # @api private
    module Extension
      class << self
        # JSON wire name => [ruby_member_name, member_shape]
        def member_index(shape)
          shape[:json_index] ||= build_member_index(shape)
        end

        # Resolves the JSON wire name for a member.
        def wire_name(member)
          member.traits[:json_name] || member.model_name
        end

        private

        def build_member_index(shape)
          index = {}
          shape.members.each do |name, member|
            next unless member.model_name

            index[wire_name(member)] = [name, member]
          end
          index.freeze
        end
      end
    end
  end
end
