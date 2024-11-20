# frozen_string_literal: true

module Smithy
  class Plan
    def initialize(*args)
      puts 'Creating a Smithy plan'
      puts "ARGS: #{args.join(', ')}"
    end
  end
end
