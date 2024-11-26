# frozen_string_literal: true

module Smithy
  class Plan
    def initialize(model, type, options = {})
      @model = Vise::Model.new(model)
      @type = type
      @options = options
    end

    # @return [Hash] The API model as a JSON hash.
    attr_reader :model

    # @return [Symbol] The type of code to generate.
    attr_reader :type

    # @return [Hash] Additional command line options.
    attr_reader :options

    # @return [String] The root directory of the build (e.g., where the Smithy CLI was invoked).
    def smithy_root_dir
      ENV['SMITHY_ROOT_DIR']
    end

    # @return [String] The working directory of the program.
    #   All files written by the program should be relative to this directory.
    def smithy_plugin_dir
      ENV['SMITHY_PLUGIN_DIR']
    end

    # @return [String] The projection name the program was called within (e.g., "source").
    def smithy_projection_name
      ENV['SMITHY_PROJECTION_NAME']
    end

    # @return [String] The plugin ID artifact name.
    def smithy_artifact_name
      ENV['SMITHY_ARTIFACT_NAME']
    end

    # @return [Boolean] Contains the value of sendPrelude in the form of true or false to tell
    #   the process if the prelude is included in the serialized model.
    def smithy_includes_prelude?
      ENV['SMITHY_INCLUDES_PRELUDE'] == 'true'
    end
  end
end
