# frozen_string_literal: true

require_relative 'seahorse/api_error'
require_relative 'seahorse/block_io'
require_relative 'seahorse/context'
require_relative 'seahorse/http'
require_relative 'seahorse/json'
require_relative 'seahorse/middleware'
require_relative 'seahorse/middleware_builder'
require_relative 'seahorse/middleware_stack'
require_relative 'seahorse/number_helper'
require_relative 'seahorse/output'
require_relative 'seahorse/structure'
require_relative 'seahorse/stubbing/client_stubs'
require_relative 'seahorse/stubbing/stubs'
require_relative 'seahorse/time_helper'
require_relative 'seahorse/union'
require_relative 'seahorse/validator'
require_relative 'seahorse/waiters/errors'
require_relative 'seahorse/waiters/poller'
require_relative 'seahorse/waiters/waiter'
require_relative 'seahorse/xml'

module Seahorse
  VERSION = File.read(File.expand_path('../VERSION', __dir__)).strip
end
