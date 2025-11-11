# frozen_string_literal: true

module Smithy
  module Views
    module Client
      # @api private
      class Module < View
        def initialize(plan)
          @plan = plan
          _, service = plan.service.first
          @traits = service.fetch('traits', {})
          @model = plan.model
          super()
        end

        def requires
          requires = @plan.welds.map(&:add_dependencies).reduce({}, :merge)
          requires = requires.except(@plan.welds.map(&:remove_dependencies).reduce([], :+))
          requires = requires.keys
          requires <<
            if @plan.type == :schema
              'smithy-schema'
            else
              'smithy-client'
            end
          requires
        end

        def module_names
          @plan.module_name.split('::')
        end

        def module_name
          @plan.module_name
        end

        def docstrings
          lines = []
          lines.concat(title_docstrings)
          lines.concat(documentation_docstrings)
          lines.concat(deprecated_docstrings)
          lines.concat(external_documentation_docstrings)
          lines.concat(since_docstrings)
          lines.concat(unstable_docstrings)
          lines
        end

        def gem_version
          @plan.gem_version
        end

        def gem_name
          @plan.gem_name
        end

        def relative_requires
          return [] unless @plan.destination_root
          # types must come before schemas
          return %i[customizations types schema] if @plan.type == :schema

          # types must come before schemas
          # paginators must come before schemas
          # customizations must come last
          %w[types paginators schema auth_parameters auth_resolver client errors
             endpoint_parameters endpoint_provider waiters customizations]
        end

        private

        def title_docstrings
          return [] unless @traits.key?('smithy.api#title')

          [Model::YARD.title_docstring(@traits['smithy.api#title'])]
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

        def since_docstrings
          return [] unless @traits.key?('smithy.api#since')

          [Model::YARD.since_docstring(@traits['smithy.api#since'])]
        end

        def unstable_docstrings
          return [] unless @traits.key?('smithy.api#unstable')

          [Model::YARD.unstable_docstring]
        end
      end
    end
  end
end
