# frozen_string_literal: true

namespace :rubocop do
  desc 'Runs rubocop on hearth'
  task 'hearth' do
    sh('bundle exec rubocop -E -S hearth')
  end

  desc 'Runs rubocop on the hand coded ruby files (tests and middleware/plugins/ect) in codegen'
  task 'codegen' do
    sh('bundle exec rubocop -E -S codegen')
  end
end
