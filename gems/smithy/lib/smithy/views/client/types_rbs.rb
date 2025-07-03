# frozen_string_literal: true

module Smithy
  module Views
    module Client
      # @api private
      class TypesRbs < View
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
            .select { |_key, shape| %w[enum intEnum structure union].include?(shape['type']) }
            .map { |id, structure| Type.new(@model, id, structure) }
        end

        # @api private
        class Type
          def initialize(model, id, shape)
            @model = model
            @id = id
            @shape = shape
            @type = shape['type']
            @members = build_members(shape['members'])
          end

          attr_reader :type, :members

          def name
            Model::Shape.name(@id).camelize
          end

          private

          def build_members(members)
            members.map { |name, member| Member.new(@model, name, member) }
          end
        end

        # @api private
        class Member
          def initialize(model, name, member)
            @model = model
            @name = name
            @id = member['target']
            @target = Model.shape(@model, member['target'])
          end

          attr_reader :name

          def rbs_type
            Model::RBS.type(@model, @id, @target)
          end
        end
      end
    end
  end
end
