# frozen_string_literal: true

require 'base64'

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
            .map { |id, shape| Type.new(@plan.service, @model, id, shape) }
        end

        # @api private
        class Type
          def initialize(service, model, id, shape)
            _, service = service.first
            @shape = shape
            @type = @shape['type']
            @name = service.fetch('rename', {})[id] || Model::Shape.name(id).camelize
            @members = shape['members'].map { |name, member| Member.new(model, name, member) }
          end

          attr_reader :type, :name, :members

          def defaults
            @members.select { |member| member if member.default? }
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
        end

        # @api private
        class Member
          def initialize(model, name, member)
            @name = name
            @member = member
            @target = Model.shape(model, member['target'])
            @doc_type = Model::YARD.type(model, member['target'], @target)
          end

          attr_reader :name

          def default?
            @member.fetch('traits', {}).key?('smithy.api#default')
          end

          def default
            default = @member.dig('traits', 'smithy.api#default')
            case @target['type']
            when 'blob'
              "Base64.strict_decode64('#{default}')"
            when 'timestamp'
              default.is_a?(Integer) ? "Time.at(#{default})" : "Time.parse('#{default}')"
            when 'string', 'enum'
              "'#{default}'"
            else default
            end
          end

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
            lines << "  @return [#{@doc_type}]"
            lines
          end
        end
      end
    end
  end
end
