# frozen_string_literal: true

module Smithy
  module Views
    module Client
      # @api private
      class Types < View
        def initialize(plan)
          @plan = plan
          @model = plan.model
          super()
        end

        def module_name
          @plan.module_name
        end

        def types
          Model::ServiceIndex
            .new(@model)
            .shapes_for(@plan.service)
            .select { |_key, shape| %w[structure union].include?(shape['type']) }
            .map { |id, shape| Type.new(@model, id, shape) }
        end

        # @api private
        class Type
          def initialize(model, id, shape)
            @model = model
            @id = id
            @shape = shape
          end

          def docstrings
            @shape
              .fetch('traits', {})
              .fetch('smithy.api#documentation', '')
              .split("\n")
          end

          def attribute_docstrings
            lines = []
            members.each do |member|
              lines.concat(member.attribute_docstrings)
            end
            lines
          end

          def name
            Model::Shape.name(@id).camelize
          end

          def member_names
            @shape['members'].keys.map(&:underscore)
          end

          def members
            @members ||= @shape['members'].map { |name, member| Member.new(@model, name, member) }
          end

          def type
            @shape['type']
          end
        end

        # @api private
        class Member
          def initialize(model, name, member)
            @model = model
            @name = name
            @member = member
            @id = member['target']
            @target = Model.shape(model, @id)
          end

          attr_reader :name

          def docstrings
            lines = @member.fetch('traits', {}).fetch('smithy.api#documentation', '').split("\n")
            return lines unless lines.empty?

            @target.fetch('traits', {}).fetch('smithy.api#documentation', '').split("\n")
          end

          def attribute_docstrings
            lines = ["@!attribute #{@name.underscore}"]
            docstrings.each do |docstring|
              lines << "  #{docstring}"
            end
            lines << "  @return [#{Model::YARD.type(@model, @id, @target)}]"
            lines
          end
        end
      end
    end
  end
end
