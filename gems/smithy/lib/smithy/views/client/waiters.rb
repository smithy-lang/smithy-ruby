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
            next if waiters_from_trait.empty?

            operation_name = Model::Shape.name(operation_id).underscore
            waiters_from_trait.map do |waiter_name, waiter|
              waiters << Waiter.new(operation_name, waiter_name, waiter)
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
          def initialize(operation_name, name, waiter)
            @operation_name = operation_name
            @name = name
            @documentation = waiter.fetch('documentation', '')
            @acceptors = formatted_acceptors(waiter['acceptors'])
            @min_delay = waiter['minDelay'] || 2
            @max_delay = waiter['maxDelay'] || 120
            @deprecated = waiter['deprecated']
          end

          attr_reader :operation_name, :name, :documentation, :acceptors, :min_delay, :max_delay

          def docstrings
            @documentation.split("\n")
          end

          def formatted_acceptors(acceptors)
            acceptors.each { |acceptor| preprocess_acceptor(acceptor) }

            Util::HashFormatter.new(
              wrap: false,
              inline: false,
              quote_strings: true
            ).format(acceptors: acceptors).split("\n")
          end

          def preprocess_acceptor(acceptor)
            if (matcher = acceptor['matcher']['output'] || acceptor['matcher']['inputOutput'])
              matcher['path'] = Util::Underscore.underscore_jmespath(matcher['path'])
            elsif (error_type = acceptor['matcher']['errorType'])
              acceptor['matcher']['errorType'] = Model::Shape.name(error_type)
            end
          end

          def deprecated?
            @deprecated
          end
        end
      end
    end
  end
end
