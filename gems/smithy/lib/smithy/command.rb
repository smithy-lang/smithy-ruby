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

    class Smith < Base
      class_option :verbose, type: :boolean

      desc 'types', 'Generates types for the model provided to STDIN'
      def types
        invoke(:types, options)
      end

      desc 'client', 'Generates a client for the model provided to STDIN'
      def client
        invoke(:client, options)
      end

      desc 'server', 'Generates a server for the model provided to STDIN'
      def server
        raise NotImplementedError, 'server generation is not yet implemented'
      end

      no_tasks do
        def invoke(type, options)
          plan = Smithy::Plan.new($stdin.read, type, options)
          Smithy.smith(plan)
        end
      end
    end

    class CLI < Base
      desc 'smith', 'Generate code using a Smithy model'
      subcommand 'smith', Smith
    end
  end
end
