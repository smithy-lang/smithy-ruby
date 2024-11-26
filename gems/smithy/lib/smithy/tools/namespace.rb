# frozen_string_literal: true

module Smithy
  module Tools
    module Namespace
      # @return [String] Returns the namespace for the given gem name.
      def self.namespace_from_gem_name(gem_name)
        namespaces_from_gem_name(gem_name).join('::')
      end

      # @return [Array] Returns the namespaces for the given gem name.
      def self.namespaces_from_gem_name(gem_name)
        gem_name.split('-').map do |part|
          part.split('_').map(&:capitalize).join
        end
      end
    end
  end
end
