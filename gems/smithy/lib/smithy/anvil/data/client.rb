module Smithy
  module Anvil
    module Data
      class Client
        def initialize
          @operations = [:foo]
        end

        def get_binding
          binding
        end
      end
    end
  end
end