# frozen_string_literal: true

require_relative 'vise/model'
require_relative 'vise/operations_parser'
require_relative 'vise/service_parser'

require_relative 'vise/shape'
require_relative 'vise/trait'
require_relative 'vise/operation_shape'
require_relative 'vise/resource_shape'
require_relative 'vise/service_shape'
require_relative 'vise/structure_shape'

module Smithy
  # A module that parses the Smithy JSON model.
  module Vise; end
end
