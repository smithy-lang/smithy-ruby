# frozen_string_literal: true

module Smithy
  module Views
    module Client
      # @api private
      class Waiters < View
        def initialize(plan)
          @plan = plan
          @model = @plan.model
          super()
        end

        def module_name
          @plan.module_name
        end

        def waiters
          Model::ServiceIndex
            .new(@model)
            .operations_for(@plan.service)
            .map do |operation_id, operation|
              waiters_from_trait = waitable_trait(operation)
              next if waiters_from_trait.empty?

              operation_name = Model::Shape.name(operation_id).underscore

              waiters_from_trait.map do |waiter_name, waiter|
                Waiter.new(operation_name, waiter_name, waiter)
              end
            end
            .flatten
            .compact
            .sort_by(&:name)
        end

        private

        def waitable_trait(operation)
          operation.fetch('traits', {}).fetch('smithy.waiters#waitable', {})
        end

        # @api private
        class Waiter
          def initialize(operation, name, waiter)
            @operation_name = operation
            @name = name
            @documentation = waiter['documentation']
            @acceptors = formatted_acceptors(waiter['acceptors'])
            @min_delay = waiter['minDelay'] || 2
            @max_delay = waiter['maxDelay'] || 120
            @deprecated = waiter['deprecated']
            @tags = waiter['tags']
          end

          attr_reader :operation_name, :name, :documentation, :acceptors, :min_delay, :max_delay, :deprecated, :tags

          def formatted_acceptors(acceptors)
            Util::HashFormatter.new(
              wrap: false,
              inline: false,
              quote_strings: true,
              indent: '            '
            ).format(acceptors: acceptors)
          end
        end
      end
    end
  end
end
