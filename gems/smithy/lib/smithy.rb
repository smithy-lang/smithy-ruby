# frozen_string_literal: true

require_relative 'smithy/plan'

module Smithy
  VERSION = File.read(File.expand_path('../VERSION', __dir__)).strip
end