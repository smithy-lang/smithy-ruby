# frozen_string_literal: true

require 'rdoc'

RSpec::Matchers.define :be_in_documentation do |file, class_or_module, args = {}|
  match do |expected|
    rdoc = RDoc::RDoc.new
    options = RDoc::Options.new
    options.verbosity = 0
    rdoc.options = options
    rdoc.store = RDoc::Store.new(options)
    top_level = rdoc.parse_files([file]).first
    documentation = top_level.find_class_or_module(class_or_module)
    if (method = args[:method])
      documentation = documentation.find_method_named(method)
    elsif (constant = args[:constant])
      documentation = documentation.find_constant_named(constant)
    end
    @actual = documentation.comment.text
    @expected = expected.chomp
    expect(@actual).to include(@expected)
  end

  failure_message do
    differ = RSpec::Support::Differ.new
    differ.diff(@actual, @expected)
  end
end
