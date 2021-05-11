require_relative 'seahorse/api_error'
require_relative 'seahorse/block_io'
require_relative 'seahorse/http'
require_relative 'seahorse/json/engines'

require_relative 'seahorse/middleware/around_handler'
require_relative 'seahorse/middleware/build'
require_relative 'seahorse/middleware/endpoint'
require_relative 'seahorse/middleware/parse'
require_relative 'seahorse/middleware/request_handler'
require_relative 'seahorse/middleware/response_handler'
require_relative 'seahorse/middleware/retry'
require_relative 'seahorse/middleware/send'
require_relative 'seahorse/middleware/validate'

require_relative 'seahorse/middleware_builder'
require_relative 'seahorse/middleware_stack'
require_relative 'seahorse/output'
require_relative 'seahorse/time_helper'
require_relative 'seahorse/stubbing/client_stubs'
require_relative 'seahorse/stubbing/stubs'
require_relative 'seahorse/validator'

module Seahorse
  VERSION = '0.2.0'.freeze
end
