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
      method_option :gem_name, type: :string, required: true,
                    desc: 'The name of the gem to generate'
      method_option :gem_version , type: :string, required: true,
                    desc: 'The version of the gem to generate'
      method_option :gem_namespace, type: :string,
                    desc: 'The namespace of the gem to generate, e.g. `MyGem::Namespace`.' \
                          'If not provided, the gem name will be used to infer the namespace.'
      desc 'types', 'Generates types for the model provided to STDIN'
      def types
        invoke(:types, options)
      end

      method_option :gem_name, type: :string, required: true,
                    desc: 'The name of the gem to generate'
      method_option :gem_version , type: :string, required: true,
                    desc: 'The version of the gem to generate'
      method_option :gem_namespace, type: :string,
                    desc: 'The namespace of the gem to generate, e.g. `MyGem::Namespace`.' \
                          'If not provided, the gem name will be used to infer the namespace.'
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
