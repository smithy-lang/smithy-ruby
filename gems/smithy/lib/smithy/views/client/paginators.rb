# frozen_string_literal: true

module Smithy
  module Views
    module Client
      # @api private
      class Paginators < View
        def initialize(plan)
          @plan = plan
          @model = plan.model
          _, service = plan.service.first
          @service_trait = paginated_trait(service)
          super()
        end

        def module_name
          @plan.module_name
        end

        def paginators
          Model::ServiceIndex
            .new(@model)
            .operations_for(@plan.service)
            .map do |id, operation|
              operation_trait = paginated_trait(operation)
              next if operation_trait.empty?

              resolved_trait = @service_trait.merge(operation_trait)
              Paginator.new(Model::Shape.name(id), resolved_trait)
            end
            .compact
        end

        private

        def paginated_trait(shape)
          shape.fetch('traits', {}).fetch('smithy.api#paginated', {})
        end

        # @api private
        class Paginator
          def initialize(name, trait)
            @name = name
            @input_token = trait['inputToken']
            @output_token = trait['outputToken']
            @items = trait['items']
          end

          attr_reader :name

          def next_tokens_code
            next_token_getter = output_getter(@output_token)
            code = ["next_token = #{next_token_getter}"]
            code << 'return {} if next_token.nil? || next_token.empty?'
            code << ''
            code << 'tokens = Hash.new { |h, k| h[k] = {} }'
            next_token_setter = input_getter(@input_token, 'tokens')
            code << "#{next_token_setter} = next_token"
            code << 'tokens'
            code
          end

          def prev_tokens_code
            prev_token_getter = input_getter(@input_token)
            code = ["prev_token = #{prev_token_getter}"]
            code << 'return {} if prev_token.nil? || prev_token.empty?'
            code << ''
            code << 'tokens = Hash.new { |h, k| h[k] = {} }'
            prev_token_setter = input_getter(@input_token, 'tokens')
            code << "#{prev_token_setter} = prev_token"
            code << 'tokens'
            code
          end

          def items_code
            return ["raise NotImplementedError, 'item iteration is not implemented for this operation'"] unless items?

            [output_getter(@items)]
          end

          def items?
            !!@items
          end

          # Builds a getter using the output shape and a path.
          # This is used to get the value of the output token or items.
          def output_getter(path)
            getter = String.new('data')
            path.split('.').each do |member|
              getter << ".#{member.underscore}"
            end
            getter
          end

          # Builds a getter using the input shape and a path.
          # This is used to set the value of the input token or fetch the previous token.
          def input_getter(path, context = 'params')
            getter = String.new(context)
            path.split('.').each do |member|
              getter << "[:#{member.underscore}]"
            end
            getter
          end
        end
      end
    end
  end
end
