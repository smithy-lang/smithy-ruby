# frozen_string_literal: true

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
