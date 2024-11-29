# frozen_string_literal: true

require 'stringio'

module Smithy
  module Anvil
    module Views
      class Module < View
        def initialize(plan)
          @plan = plan
          @model = plan.model
          @gem_name = plan.options[:gem_name]
        end

        def requires
          case @plan.type
          when :types
            ["#{@gem_name}-types/types"]
          else
            []
          end
        end

        def documentation
          _id, service =  @model.shapes.find { |_key, shape| shape.type == 'service' }
          _id, trait = service.traits.find { |_id, trait| trait.id == 'smithy.api#documentation' }
          "# #{trait.data}"
        end

        def namespace
          namespaces = Tools::Namespace.namespaces_from_gem_name(@gem_name)
          version = @plan.options[:gem_version]
          str = StringIO.new
          namespaces.each_with_index do |namespace, i|
            str << 'module ' + namespace + "\n"
            str << '  ' * (i + 1) if i < namespaces.size - 1
          end
          str << "  VERSION = '#{version}'\n"
          namespaces.each_with_index do |namespace, i|
            str << '  ' * (namespaces.size - i - 1)
            str << "end\n"
          end
          str.string
        end
      end
    end
  end
end
