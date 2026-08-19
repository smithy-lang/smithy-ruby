# frozen_string_literal: true

module Smithy
  module Json
    # @api private
    module Extension
      class << self
        # wire (jsonName or model_name) => [member_name, member_shape]
        def member_index(shape)
          shape[:json_index] ||= build_member_index(shape)
        end

        # per-member forward wire name (jsonName or model_name)
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
