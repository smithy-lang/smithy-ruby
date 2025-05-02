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
          waiters = []
          operations = Model::ServiceIndex.new(@model).operations_for(@plan.service)
          operations.each do |operation_id, operation|
            waiters_from_trait = waitable_trait(operation)
            unless waiters_from_trait.empty?
              operation_name = Model::Shape.name(operation_id).underscore
              waiters_from_trait.map do |waiter_name, waiter|
                waiters << Waiter.new(operation_name, waiter_name, waiter)
              end
            end
          end
          waiters.sort_by(&:name)
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
          end

          attr_reader :operation_name, :name, :documentation, :acceptors, :min_delay, :max_delay, :deprecated

          def formatted_acceptors(acceptors)
            acceptors.each do |acceptor|
              if (matcher = acceptor['matcher']['output'])
                matcher['path'] = Util::Underscore.underscore_jmespath(matcher['path'])
              elsif (matcher = acceptor['matcher']['inputOutput'])
                matcher['path'] = Util::Underscore.underscore_jmespath(matcher['path'])
              end
            end

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
