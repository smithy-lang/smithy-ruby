# frozen_string_literal: true

require_relative 'vise/operations_parser'
require_relative 'vise/service_parser'

require_relative 'vise/shape'
require_relative 'vise/trait'

require_relative 'vise/enum_shape'
require_relative 'vise/int_enum_shape'
require_relative 'vise/list_shape'
require_relative 'vise/map_shape'
require_relative 'vise/member_shape'
require_relative 'vise/operation_shape'
require_relative 'vise/resource_shape'
require_relative 'vise/service_shape'
require_relative 'vise/structure_shape'
require_relative 'vise/union_shape'

require_relative 'vise/model'

module Smithy
  # A module that parses the Smithy JSON model.
  module Vise; end
end
