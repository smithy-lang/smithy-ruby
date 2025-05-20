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
            .map { |id, shape| Type.new(@plan.service, @model, id, shape) }
        end

        # @api private
        class Type
          def initialize(service, model, id, shape)
            _, service = service.first
            @shape = shape
            @type = shape['type']
            @name = (service.dig('rename', id) || Model::Shape.name(id)).camelize
            @members = shape['members'].map { |name, member| Member.new(service, model, name, member) }
            @traits = shape.fetch('traits', {})
          end

          attr_reader :type, :name, :members

          def input?
            @traits.key?('smithy.api#input')
          end

          def defaults
            @members.select { |member| member if member.default? }
          end

          def docstrings
            lines = []
            lines.concat(documentation_docstrings)
            lines.concat(deprecated_docstrings)
            lines.concat(external_documentation_docstrings)
            lines.concat(sensitive_docstrings)
            lines.concat(since_docstrings)
            lines.concat(unstable_docstrings)
            lines
          end

          def attribute_docstrings
            lines = []
            members.each do |member|
              lines.concat(member.docstrings)
            end
            lines
          end

          def documentation_docstrings
            @traits.fetch('smithy.api#documentation', '').split("\n")
          end

          def deprecated_docstrings
            return [] unless @traits.key?('smithy.api#deprecated')

            message = @traits['smithy.api#deprecated'].fetch('message', '')
            since = @traits['smithy.api#deprecated'].fetch('since', '')
            Model::YARD.deprecated_docstrings(message, since)
          end

          def external_documentation_docstrings
            return [] unless @traits.key?('smithy.api#externalDocumentation')

            hash = @traits.fetch('smithy.api#externalDocumentation', {})
            Model::YARD.external_documentation_docstrings(hash)
          end

          def sensitive_docstrings
            return [] unless @traits.key?('smithy.api#sensitive')

            [Model::YARD.sensitive_docstring]
          end

          def since_docstrings
            return [] unless @traits.key?('smithy.api#since')

            [Model::YARD.since_docstring(@traits['smithy.api#since'])]
          end

          def unstable_docstrings
            return [] unless @traits.key?('smithy.api#unstable')

            [Model::YARD.unstable_docstring]
          end
        end

        # @api private
        class Member
          def initialize(service, model, name, member)
            @service = service
            @model = model
            @name = name
            @member = member
            @traits = member.fetch('traits', {})
            @target = Model.shape(model, member['target'])
          end

          attr_reader :name

          def indented_docstrings(docstrings)
            docstrings.map { |docstring| "  #{docstring}" }
          end

          def docstrings # rubocop:disable Metrics/AbcSize
            lines = ["@!attribute #{@name.underscore}"]
            lines.concat(indented_docstrings(documentation_docstrings))
            lines.concat(indented_docstrings(deprecated_docstrings))
            lines.concat(indented_docstrings(external_documentation_docstrings))
            lines.concat(indented_docstrings(recommended_docstrings))
            lines.concat(indented_docstrings(since_docstrings))
            lines.concat(indented_docstrings(unstable_docstrings))
            lines.concat(indented_docstrings(return_docstrings))
            lines
          end

          def documentation_docstrings
            lines = @member.fetch('traits', {}).fetch('smithy.api#documentation', '').split("\n")
            return lines unless lines.empty?

            @target.fetch('traits', {}).fetch('smithy.api#documentation', '').split("\n")
          end

          def deprecated_docstrings
            return [] unless @traits.key?('smithy.api#deprecated')

            message = @traits['smithy.api#deprecated'].fetch('message', '')
            since = @traits['smithy.api#deprecated'].fetch('since', '')
            Model::YARD.deprecated_docstrings(message, since)
          end

          def external_documentation_docstrings
            return [] unless @traits.key?('smithy.api#externalDocumentation')

            hash = @traits.fetch('smithy.api#externalDocumentation', {})
            Model::YARD.external_documentation_docstrings(hash)
          end

          def recommended_docstrings
            return [] unless @traits.key?('smithy.api#recommended')

            reason = @traits['smithy.api#recommended'].fetch('reason', '')
            Model::YARD.recommended_docstrings(reason)
          end

          def since_docstrings
            return [] unless @traits.key?('smithy.api#since')

            [Model::YARD.since_docstring(@traits['smithy.api#since'])]
          end

          def unstable_docstrings
            return [] unless @traits.key?('smithy.api#unstable')

            [Model::YARD.unstable_docstring]
          end

          def return_docstrings
            [Model::YARD.return_docstring(@service, @model, @member['target'], @target)]
          end

          def default?
            traits = @member.fetch('traits', {})
            traits.key?('smithy.api#default') && !traits.key?('smithy.api#clientOptional')
          end

          def default
            default = @member.dig('traits', 'smithy.api#default')
            case @target['type']
            when 'blob' then "Base64.strict_decode64('#{default}')"
            when 'bigDecimal' then "BigDecimal('#{default}')"
            when 'document' then document(default)
            when 'enum', 'string' then "'#{default}'"
            when 'timestamp' then timestamp(default)
            else default
            end
          end

          def document(default)
            case default
            when nil then 'nil'
            when String then "'#{default}'"
            else default
            end
          end

          def timestamp(default)
            case default
            when Integer then "Time.at(#{default})"
            when String then "Time.parse('#{default}')"
            else default
            end
          end
        end
      end
    end
  end
end
