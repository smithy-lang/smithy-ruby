# frozen_string_literal: true

module Smithy
  module Model
    # @api private
    class YARD
      class << self
        def deprecated_docstrings(message, since)
          lines = ['@deprecated']
          lines << "  #{escape(message)}" unless message.empty?
          lines << "  Since: #{escape(since)}" unless since.empty?
          lines
        end

        def external_documentation_docstrings(hash)
          hash.map { |key, value| "@see #{escape(value)} #{escape(key)}" }
        end

        def option_docstrings(service, model, id, shape, option, docstrings) # rubocop:disable Metrics/ParameterLists
          lines = ["@option params [#{type(service, model, id, shape)}] :#{option}"]
          docstrings.each do |docstring|
            lines << "  #{docstring}"
          end
          lines
        end

        def param_docstring(service, model, id, shape)
          "@param [Hash, #{type(service, model, id, shape)}] params"
        end

        def recommended_docstrings(reason)
          lines = ['@note']
          lines << '  This shape is recommended'
          lines << "  Reason: #{escape(reason)}" unless reason.empty?
          lines
        end

        def return_docstring(service, model, id, shape)
          "@return [#{type(service, model, id, shape)}]"
        end

        def sensitive_docstring
          '@note This shape contains sensitive data and should be treated as such.'
        end

        def since_docstring(since)
          "@since #{escape(since)}"
        end

        def title_docstring(title)
          "@title #{escape(title)}"
        end

        private

        def type(service, model, id, shape) # rubocop:disable Metrics/CyclomaticComplexity
          case shape['type']
          when 'blob', 'string', 'enum' then 'String'
          when 'boolean' then 'Boolean'
          when 'byte', 'short', 'integer', 'long', 'intEnum' then 'Integer'
          when 'float', 'double' then 'Float'
          when 'timestamp' then 'Time'
          when 'document' then 'JSON'
          when 'list' then list(service, model, shape)
          when 'map' then map(service, model, shape)
          when 'structure', 'union' then structure(service, id)
          else 'Object'
          end
        end

        def structure(service, id)
          return 'Smithy::Schema::EmptyStructure' if id == 'smithy.api#Unit'

          "Types::#{(service.dig('rename', id) || Model::Shape.name(id)).camelize}"
        end

        def map(service, model, shape)
          key_target = Model.shape(model, shape['key']['target'])
          value_target = Model.shape(model, shape['value']['target'])
          key_type = type(service, model, shape['key']['target'], key_target)
          value_type = type(service, model, shape['value']['target'], value_target)
          "Hash<#{key_type}, #{value_type}>"
        end

        def list(service, model, shape)
          member_target = Model.shape(model, shape['member']['target'])
          "Array<#{type(service, model, shape['member']['target'], member_target)}>"
        end

        def escape(string)
          string.split("\n").join(' ')
        end
      end
    end
  end
end
