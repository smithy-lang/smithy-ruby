# frozen_string_literal: true

module Smithy
  module Vise
    # @api private
    class ServiceParser
      def initialize(shapes)
        @shapes = shapes
      end

      def parse
        services = @shapes.each_value.select { |v| v.type == 'service' }
        raise 'Multiple service shapes found' if services.size > 1

        service = services.first
        raise 'No service shape found' if service.nil?

        service
      end
    end
  end
end
