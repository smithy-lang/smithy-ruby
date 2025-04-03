# frozen_string_literal: true

require_relative 'smithy-schema/shapes'
require_relative 'smithy-schema/structure'
require_relative 'smithy-schema/document'
require_relative 'smithy-schema/type_registry'
require_relative 'smithy-schema/union'

module Smithy
  # Base module for Smithy schema classes.
  module Schema
    VERSION = File.read(File.expand_path('../VERSION', __dir__.to_s)).strip
  end
end
