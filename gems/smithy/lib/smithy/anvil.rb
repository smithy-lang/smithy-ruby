# frozen_string_literal: true

require 'erb'

require_relative 'anvil/data/client'

module Smithy
  module Anvil
    def self.hammer(plan)
      render_client("#{plan.smithy_plugin_dir}/client.rb")
    end

    private

    def self.render_client(path)
      o = Data::Client.new
      render_template('client', path, o)
    end

    def self.render_template(template_name, path, object)
      template = File.join(File.dirname(__FILE__), 'anvil', 'templates', template_name + '.rb.tt')
      data = File.join(File.dirname(__FILE__), 'anvil', 'data', template_name + '.rb')
      raise ArgumentError, "Corresponding data " + data + " not found" unless File.exist?(data)

      erb = ERB.new(File.read(template), trim_mode: '<>')
      File.open(path, 'w') do |file|
        file.write(erb.result(object.get_binding))
      end
    end
  end
end
