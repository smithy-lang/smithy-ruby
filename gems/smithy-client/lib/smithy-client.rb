# frozen_string_literal: true

require_relative 'smithy-client/structure'
require_relative 'smithy-client/union'

module Smithy
  module Client
    VERSION = File.read(File.expand_path('../VERSION', __dir__)).strip
  end
end
