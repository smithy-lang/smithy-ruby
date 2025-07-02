# frozen_string_literal: true

module Smithy
  module Views
    module Client
      # @api private
      class Client < View
        def initialize(plan, code_generated_plugins)
          @plan = plan
          @model = plan.model
          _, @service = plan.service.first
          @plugins = PluginList.new(plan, code_generated_plugins)
          super()
        end

        def require_plugins
          requires = []
          @plugins.each do |plugin|
            next if !@plan.destination_root && plugin.require_relative?

            requires << "require#{'_relative' if plugin.require_relative?} '#{plugin.require_path}'"
          end
          requires
        end

        def module_name
          @plan.module_name
        end

        def service_name
          id, = @plan.service.first
          Model::Shape.name(id).camelize
        end

        def add_plugins
          @plugins.map(&:class_name)
        end

        def docstrings
          options = @plugins.map(&:options).flatten.sort_by(&:name)
          documentation = {}
          options.each do |option|
            documentation[option.name] = option_docstrings(option) if option.docstring
          end
          lines = []
          documentation.each_value { |value| lines.concat(value) }
          lines
        end

        def operations
          Model::ServiceIndex
            .new(@model)
            .operations_for(@plan.service)
            .map { |id, operation| Operation.new(@service, @model, id, operation) }
        end

        def gem_name
          @plan.gem_name
        end

        def gem_version
          @plan.gem_version
        end

        # TODO: re-evaluate this approach - perhaps plugins should register protocol classes with options
        def protocols
          @protocols ||= @plan.welds.map(&:protocols).reduce({}, :merge)
        end

        def waiters
          waiters = Views::Client::Waiters.new(@plan).waiters
          return ['{}'] if waiters.empty?

          lines = ['{']
          waiters.each do |waiter|
            lines << "  #{waiter.name.underscore}: Waiters::#{waiter.name},"
          end
          lines.last.chomp!(',') if lines.last.end_with?(',')
          lines << '}'
          lines
        end

        private

        def option_docstrings(option)
          lines = []
          lines << option_tag(option)
          documentation = option.docstring.split("\n").map { |line| " #{line}" }
          lines.concat(documentation)
          lines
        end

        def option_tag(option)
          tag = StringIO.new
          tag << '@option options'
          tag << " [#{option.doc_type}]" if option.doc_type
          tag << " :#{option.name}"
          default = option_default(option)
          tag << " (#{default})" if default
          tag.string
        end

        def option_default(option)
          # TODO: wrap default in strings if doc_type is String or Symbol
          default = option.doc_default || option.default

          case option.name
          when :protocol
            protocol = protocols.keys.first
            default.gsub('<DEFAULT_PROTOCOL>', protocol ? "'#{protocol}'" : 'nil')
          when :auth_resolver
            default.gsub('<DEFAULT_AUTH_RESOLVER>', "#{module_name}::AuthResolver.new")
          else
            default
          end
        end

        # @api private
        class Operation
          def initialize(service, model, id, operation)
            @service = service
            @model = model
            @id = id
            @operation = operation
            @traits = operation.fetch('traits', {})
          end

          def docstrings # rubocop:disable Metrics/AbcSize
            lines = []
            lines.concat(documentation_docstrings)
            lines.concat(params_docstrings)
            lines.concat(OperationExamples.new(@model, method_name, @operation).docstrings)
            lines.concat(RequestResponseExample.new(@model, method_name, @operation).docstrings)
            lines.concat(deprecated_docstrings)
            lines.concat(external_documentation_docstrings)
            lines.concat(since_docstrings)
            lines.concat(unstable_docstrings)
            lines.concat(return_docstrings)
            lines
          end

          def method_name
            Model::Shape.name(@id).underscore
          end

          private

          def documentation_docstrings
            @traits.fetch('smithy.api#documentation', '').split("\n")
          end

          def params_docstrings
            input_target = @operation['input']['target']
            input = Model.shape(@model, input_target)

            lines = []
            lines << Model::YARD.param_docstring(@service, @model, input_target, input)
            input['members'].each do |member_name, member_shape|
              target = Model.shape(@model, member_shape['target'])
              docstrings = Model::YARD.option_docstrings(
                @service,
                @model,
                member_shape['target'],
                target,
                member_name.underscore,
                param_docstrings(member_shape, target)
              )
              lines.concat(docstrings)
            end
            lines
          end

          def param_docstrings(member_shape, target)
            documentation = member_shape.fetch('traits', {}).fetch('smithy.api#documentation', '').split("\n")
            return documentation unless documentation.empty?

            target.fetch('traits', {}).fetch('smithy.api#documentation', '').split("\n")
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

          def return_docstrings
            output_target = @operation['output']['target']
            output = Model.shape(@model, output_target)
            [Model::YARD.return_docstring(@service, @model, output_target, output)]
          end
        end
      end
    end
  end
end
