# frozen_string_literal: true

require 'pathname'

module Smithy
  module Client
    # @api private
    class LogParamFormatter
      # String longer than the max string size are truncated
      MAX_STRING_SIZE = 1000

      def initialize(options = {})
        @max_string_size = options[:max_string_size] || MAX_STRING_SIZE
      end

      def summarize(value)
        case value
        when Array then "[#{array(value)}]"
        when File then file(value)
        when Hash then "{ #{hash(value)} }"
        when Pathname then pathname(value)
        when String then string(value)
        when Tempfile then tempfile(value)
        else value.inspect
        end
      end

      private

      def string(str)
        if str.size > @max_string_size
          "#<String #{str[0...@max_string_size].inspect} ... (#{str.size} bytes)>"
        else
          str.inspect
        end
      end

      def hash(hash)
        hash.map do |key, value|
          if key.is_a?(String)
            "#{key.inspect} => #{summarize(value)}"
          else
            "#{key}: #{summarize(value)}"
          end
        end.join(', ')
      end

      def array(array)
        array.map { |v| summarize(v) }.join(', ')
      end

      def file(file)
        "#<File:#{file.path} (#{file.size} bytes)>"
      end

      def tempfile(file)
        "#<Tempfile:#{file.path} (#{file.size} bytes)>"
      end

      def pathname(path)
        "#<Pathname:#{path} (#{File.size(path)} bytes)>"
      end
    end
  end
end
