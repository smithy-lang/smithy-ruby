# frozen_string_literal: true

require 'optparse'
require 'json'

module Smithy
  class Plan
    def initialize(model)
      @model = JSON.parse(model)
      @options = {}
      parse_args
      parse_env
    end

    # @return [Hash] The API model as a JSON hash.
    attr_reader :model

    # @return [Hash] The command line options.
    attr_reader :options

    private

    def parse_args
      OptionParser.new do |opts|
        opts.banner = "Usage: smithy-ruby [options]"
        opts.on("-v", "--[no-]verbose", "Run verbosely") do |v|
          @options[:verbose] = v
        end
      end.parse!
    end

    def parse_env
      @options.merge!(
        root_dir: ENV['SMITHY_ROOT_DIR'],
        plugin_dir: ENV['SMITHY_PLUGIN_DIR'],
        projection_name: ENV['SMITHY_PROJECTION_NAME'],
        artifact_name: ENV['SMITHY_ARTIFACT_NAME'],
        includes_prelude: ENV['SMITHY_INCLUDES_PRELUDE']
      )
    end
  end
end
