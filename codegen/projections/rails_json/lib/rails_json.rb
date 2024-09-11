# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

require 'hearth'
require_relative 'rails_json/auth'
require_relative 'rails_json/builders'
require_relative 'rails_json/client'
require_relative 'rails_json/config'
begin
  require_relative 'rails_json/customizations'
rescue LoadError; end
require_relative 'rails_json/errors'
require_relative 'rails_json/endpoint'
require_relative 'rails_json/middleware'
require_relative 'rails_json/paginators'
require_relative 'rails_json/params'
require_relative 'rails_json/parsers'
require_relative 'rails_json/stubs'
require_relative 'rails_json/telemetry'
require_relative 'rails_json/types'
require_relative 'rails_json/validators'
require_relative 'rails_json/waiters'

module RailsJson
  VERSION = File.read(File.expand_path('../VERSION', __dir__)).strip
end
