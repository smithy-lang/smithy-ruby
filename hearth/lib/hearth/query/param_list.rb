# frozen_string_literal: true

module Hearth
  module Query
    # A class used to collect query params before serialization.
    # @api private
    class ParamList
      include Enumerable

      # @api private
      def initialize
        @params = {}
      end

      # @param [String] param_name
      # @param [String, nil] param_value
      # @return [Param]
      def set(param_name, param_value = nil)
        param = Param.new(param_name, param_value)
        @params[param.name] = param
        param
      end
      alias []= set

      # @return [Param, nil]
      def [](param_name)
        @params[param_name]
      end

      # @param [String] param_name
      # @return [Param, nil]
      def delete(param_name)
        @params.delete(param_name)
      end

      # @return [Enumerable]
      def each(&block)
        to_a.each(&block)
      end

      # @return [Boolean]
      def empty?
        @params.empty?
      end

      # @return [Array<Param>] Returns an array of sorted {Param} objects.
      def to_a
        @params.values.sort
      end

      # @return [String]
      def to_s
        to_a.map(&:to_s).join('&')
      end
    end
  end
end
