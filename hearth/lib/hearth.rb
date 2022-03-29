# frozen_string_literal: true

require_relative 'hearth/api_error'
require_relative 'hearth/block_io'
require_relative 'hearth/checksums'
require_relative 'hearth/context'
require_relative 'hearth/http'
require_relative 'hearth/json'
require_relative 'hearth/middleware'
require_relative 'hearth/middleware_builder'
require_relative 'hearth/middleware_stack'
require_relative 'hearth/number_helper'
require_relative 'hearth/output'
require_relative 'hearth/query'
require_relative 'hearth/structure'
require_relative 'hearth/stubbing/client_stubs'
require_relative 'hearth/stubbing/stubs'
require_relative 'hearth/time_helper'
require_relative 'hearth/union'
require_relative 'hearth/validator'
require_relative 'hearth/waiters/errors'
require_relative 'hearth/waiters/poller'
require_relative 'hearth/waiters/waiter'
require_relative 'hearth/xml'

module Hearth
  VERSION = File.read(File.expand_path('../VERSION', __dir__)).strip
end
