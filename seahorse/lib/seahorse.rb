require_relative 'seahorse/api_error'
require_relative 'seahorse/block_io'
require_relative 'seahorse/buffered_io'
require_relative 'seahorse/default_list'
require_relative 'seahorse/default_map'
require_relative 'seahorse/http'
require_relative 'seahorse/middleware'
require_relative 'seahorse/middleware_builder'
require_relative 'seahorse/middleware_stack'
require_relative 'seahorse/params'
require_relative 'seahorse/response'
require_relative 'seahorse/struct_addons'
require_relative 'seahorse/time_helper'
require_relative 'seahorse/xml'

module Seahorse
  VERSION = '1.0.0.pre1'.freeze
end
