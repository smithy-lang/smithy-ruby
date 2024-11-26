# frozen_string_literal: true

require_relative 'forge/types'

module Smithy
  module Forge
    def self.forge(plan)
      sources = source_files(plan)
      write_source_files(sources, plan.smithy_plugin_dir)
      sources
    end

    class << self
      private

      def source_files(plan)
        case plan.type
        when :types then Types.new(plan).forge
        when :client then raise 'Not yet implemented'
        when :server then raise 'Not yet implemented'
        else
          raise 'Unknown plan type'
        end
      end

      def write_source_files(sources, dest)
        sources.each do |path, code|
          path = File.join(dest, path)
          FileUtils.mkdir_p(File.dirname(path))
          File.open(path, 'wb') { |file| file.write(code) }
        end
      end
    end
  end
end
