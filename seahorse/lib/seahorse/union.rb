# frozen_string_literal: true

require 'delegate'

module Seahorse
  # Top level class for all Union types
  class Union < ::SimpleDelegator; end
end
