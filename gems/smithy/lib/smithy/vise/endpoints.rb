# frozen_string_literal: true

require_relative 'endpoints/built_in_binding'
require_relative 'endpoints/function_binding'

module Smithy
  module Vise
    # Endpoint Rules related metadata
    # TODO: Where does this actually belong.
    # it could be in vise because its related to understanding the model
    # it could be in anvil because its related to generating views
    # could be top level, because its related to welds?
    # it could be in weld because it relates to extension points
    module Endpoints
    end
  end
end
