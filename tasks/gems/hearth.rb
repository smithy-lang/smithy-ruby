# frozen_string_literal: true

# Modify load path to include codegen gems from build directories
projections = 'codegen/*/build/smithyprojections/**/ruby-codegen/*/lib'
Dir.glob(projections) do |gem_path|
  $LOAD_PATH.unshift(File.expand_path(gem_path))
end

module Benchmark
  module Gems
    class Hearth < Benchmark::Gem
      def gem_name
        'hearth'
      end

      def gem_dir
        'hearth'
      end

      # Hearth does not have a client and does not have any operation benchmarks
    end
  end
end
