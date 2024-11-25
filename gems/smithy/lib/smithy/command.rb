# frozen_string_literal: true

require 'thor'

module Smithy
  # @api private
  module Command
    class Base < Thor
      # Necessary to report the correct status to the parent process (`smithy build`)
      def self.exit_on_failure?
        true
      end
    end

    class Smith < Command::Base
      desc 'types', 'Generates types for the model provided to STDIN'
      def types
        puts 'Generating types!'
        plan = Smithy::Plan.new($stdin.read, :types)
        Smithy.smith(plan)
      end

      desc 'client', 'Generates a client for the model provided to STDIN'
      def client
        puts 'Generating client!'
        plan = Smithy::Plan.new($stdin.read, :client)
        Smithy.smith(plan)
      end

      desc 'server', 'Generates a server for the model provided to STDIN'
      def server
        raise NotImplementedError, 'server generation is not yet implemented'
      end
    end

    class CLI < Command::Base
      desc 'smith', 'Generate code using a Smithy model'
      subcommand 'smith', Smith
    end
  end
end
