# frozen_string_literal: true

module Smithy
  module Vise
    # Finds a service shape in a set of shapes.
    class ServiceIndex
      def initialize(model)
        @service = find_service(model['shapes'])
      end

      # @return [ServiceShape] The service shape for the shapes.
      attr_reader :service

      private

      def find_service(shapes)
        services = shapes.select { |_, shape| shape['type'] == 'service' }
        raise 'Multiple service shapes found' if services.size > 1
        raise 'No service shape found' if services.empty?

        services
      end
    end
  end
end
