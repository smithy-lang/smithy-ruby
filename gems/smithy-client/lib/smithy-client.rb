# frozen_string_literal: true

require_relative 'smithy-client/api'
require_relative 'smithy-client/configuration'
require_relative 'smithy-client/handler'
require_relative 'smithy-client/handler_builder'
require_relative 'smithy-client/handler_list'
require_relative 'smithy-client/handler_list_entry'
require_relative 'smithy-client/operation'
require_relative 'smithy-client/plugin'
require_relative 'smithy-client/plugin_list'
require_relative 'smithy-client/structure'

module Smithy
  # Base module for a generated Smithy gem.
  module Client
    VERSION = File.read(File.expand_path('../VERSION', __dir__)).strip
  end
end
