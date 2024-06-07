# frozen_string_literal: true

$white_label_dir = 'codegen/smithy-ruby-codegen-test/build/smithyprojections/smithy-ruby-codegen-test/white-label/ruby-codegen/white_label'
$rpcv2cbor_dir = 'codegen/smithy-ruby-codegen-test/build/smithyprojections/smithy-ruby-codegen-test/protocoltests-rpcv2cbor/ruby-codegen/rpcv2_cbor'
$rails_json_dir = 'codegen/smithy-ruby-rails-codegen-test/build/smithyprojections/smithy-ruby-rails-codegen-test/railsjson/ruby-codegen/rails_json'

Dir.glob("tasks/**/*.rake").each do |task_file|
  load(task_file)
end

desc 'Run all checks and verifications for all sub projects'
task :default => %w[
  check:hearth
  check:codegen
]
