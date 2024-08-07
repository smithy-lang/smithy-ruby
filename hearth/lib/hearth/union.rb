# frozen_string_literal: true

require 'delegate'

module Hearth
  # Top level class for all Union types
  class Union < ::SimpleDelegator
    include Structure
  end
end
