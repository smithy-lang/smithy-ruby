# frozen_string_literal: true

module Smithy
  module Vise
    # Finds a service shape in a set of shapes.
    class ServiceIndex
      def initialize(shapes)
        @shapes = shapes
      end

      # @return [ServiceShape] The service shape for the shapes.
      def service
        services = @shapes.each_value.select { |v| v.is_a?(ServiceShape) }
        raise 'Multiple service shapes found' if services.size > 1

        service = services.first
        raise 'No service shape found' if service.nil?

        service
      end
    end
  end
end
