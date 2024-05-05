# frozen_string_literal: true

namespace :check do
  desc 'Run all verification checks on hearth - run tests, rubocop and verify types'
  task hearth: %w[
    test:hearth
    rubocop:hearth
    steep:hearth
    rbs:hearth
  ]

  desc 'Run all code generation checks/verifications - build codegen, run all tests, rubocop and verify types'
  task codegen: %w[
    codegen:clean
    codegen:build
    test:white_label
    test:smithy-core-endpoint-tests
    test:rails_json
    rubocop:codegen
    steep:white_label
    rbs:white_label
    steep:rails_json
    rbs:rails_json
  ]
end
