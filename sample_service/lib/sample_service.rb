# frozen_string_literal: true

require 'seahorse'
require 'logger'

require_relative 'sample_service/builders'
require_relative 'sample_service/client'
require_relative 'sample_service/errors'
require_relative 'sample_service/params'
require_relative 'sample_service/parsers'
require_relative 'sample_service/stubs'
require_relative 'sample_service/types'
require_relative 'sample_service/validators'

module SampleService
  GEM_VERSION = '0.0.1'
end
