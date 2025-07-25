# frozen_string_literal: true

require 'smithy-schema'

require_relative 'smithy-xml/codec'
require_relative 'smithy-xml/doc_builder'

module Smithy
  # Smithy::Xml is a purpose-built set of utilities for working with XML.
  module Xml
    VERSION = File.read(File.expand_path('../VERSION', __dir__.to_s)).strip
  end
end
