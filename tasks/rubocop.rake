namespace :rubocop do
  desc 'Runs rubocop on hearth'
  task 'hearth' do
    Dir.chdir('hearth') do
      sh('bundle exec rubocop -E -S')
    end
  end

  desc 'Runs rubocop on the hand coded ruby files (tests and middleware/plugins/ect) in codegen'
  task 'codegen' do
    Dir.chdir('codegen') do
      sh('bundle exec rubocop -E -S')
    end
  end
end
