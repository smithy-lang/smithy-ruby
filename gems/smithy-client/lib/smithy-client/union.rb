# frozen_string_literal: true

module Smithy
  module Client
    # Top level class for all Union types
    class Union < ::SimpleDelegator
      include Structure
    end
  end
end
