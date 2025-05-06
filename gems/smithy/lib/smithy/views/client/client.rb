# frozen_string_literal: true

module Smithy
  module Views
    module Client
      # @api private
      class Client < View
        def initialize(plan, code_generated_plugins)
          @plan = plan
          @model = plan.model
          @plugins = PluginList.new(plan, code_generated_plugins)
          super()
        end

        def module_name
          @plan.module_name
        end

        def gem_name
          @plan.gem_name
        end

        def gem_version
          @plan.gem_version
        end

        def require_plugins
          requires = []
          @plugins.each do |plugin|
            next if !@plan.destination_root && plugin.require_relative?

            requires << "require#{'_relative' if plugin.require_relative?} '#{plugin.require_path}'"
          end
          requires
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
            .map { |id, operation| Operation.new(@model, id, operation) }
        end

        def protocols
          @protocols ||= @plan.welds.map(&:protocols).reduce({}, :merge)
        end

        def waiters
          waiters = Views::Client::Waiters.new(@plan).waiters
          return ['{}'] if waiters.empty?

          lines = ['{']
          waiters.each_with_index do |waiter, i|
            line = "  #{waiter.name.underscore}: Waiters::#{waiter.name},"
            line.chomp!(',') if i == waiters.length - 1
            lines << line
          end
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
          default = option.doc_default || option.default
          return default unless option.name == :protocol

          default.gsub('<DEFAULT_PROTOCOL>', protocols.keys.first || 'nil')
        end

        # @api private
        class Operation
          def initialize(model, id, operation)
            @model = model
            @id = id
            @operation = operation
          end

          def docstrings
            lines = []
            lines.concat(documentation)
            lines.concat(params_docstrings)
            lines.concat(return_docstring)
            lines.concat(OperationExamples.new(@model, name, @operation).docstrings)
            lines.concat(RequestResponseExample.new(@model, name, @operation).docstrings)
            lines
          end

          def name
            Model::Shape.name(@id).underscore
          end

          private

          def documentation
            @operation
              .fetch('traits', {})
              .fetch('smithy.api#documentation', '')
              .split("\n")
          end

          def params_docstrings
            lines = ['@param [Hash] params']
            input = Model.shape(@model, @operation['input']['target'])
            input['members'].each do |name, member|
              target = Model.shape(@model, member['target'])
              type = Model::YARD.type(@model, member['target'], target)
              lines << "@option params [#{type}] :#{name.underscore}"
              param_docstring(member).each do |docstring|
                lines << "  #{docstring}"
              end
            end
            lines
          end

          def return_docstring
            lines = []
            output = Model.shape(@model, @operation['output']['target'])
            lines << "@return [#{Model::YARD.type(@model, @operation['output']['target'], output)}]"
            lines
          end

          def param_docstring(member)
            documentation = member.fetch('traits', {}).fetch('smithy.api#documentation', '').split("\n")
            return documentation unless documentation.empty?

            target = Model.shape(@model, member['target'])
            target.fetch('traits', {}).fetch('smithy.api#documentation', '').split("\n")
          end
        end
      end
    end
  end
end
