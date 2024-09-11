# frozen_string_literal: true

$white_label_dir = 'codegen/projections/white_label'
$rpcv2_cbor_dir = 'codegen/projections/rpcv2_cbor'
$rails_json_dir = 'codegen/projections/rails_json'

Dir.glob("tasks/**/*.rake").each do |task_file|
  load(task_file)
end

desc 'Run all checks and verifications for all sub projects'
task :default => %w[
  check:hearth
  check:codegen
]
