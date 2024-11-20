# frozen_string_literal: true

require 'optparse'
require 'json'

module Smithy
  class Plan
    def initialize(model)
      @model = JSON.parse(model)
      parse_options
    end

    # @return [Hash] The API model as a JSON hash.
    attr_reader :model

    # @return [Hash] The command line options.
    attr_reader :options

    def smith
      puts 'Run generation here'
      puts "The model is: #{@model}"
      puts "Options are: #{@options}"
      puts "Root directory: #{ENV['SMITHY_ROOT_DIR']}"
      puts "Output should be written to: #{ENV['SMITHY_PLUGIN_DIR']}"
      puts "Projection name: #{ENV['SMITHY_PROJECTION_NAME']}"
      puts "Artifact name: #{ENV['SMITHY_ARTIFACT_NAME']}"
      puts "Includes prelude: #{ENV['SMITHY_INCLUDES_PRELUDE']}"
    end

    private

    def parse_options
      @options = {}
      OptionParser.new do |opts|
        opts.banner = "Usage: smithy-ruby [options]"
        opts.on("-v", "--[no-]verbose", "Run verbosely") do |v|
          @options[:verbose] = v
        end
      end.parse!
    end
  end
end
