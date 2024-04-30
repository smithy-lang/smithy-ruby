namespace :steep do
  desc 'Run steep check on hearth'
  task 'hearth' do
    Dir.chdir('hearth') do
      sh('bundle exec steep check')
    end
  end

  desc 'Run steep check on white_label'
  task 'white_label' do
    Dir.chdir($white_label_dir) do
      sh('bundle exec steep check')
    end
  end

  desc 'Run steep check on rails_json'
  task 'rails_json' do
    Dir.chdir($rails_json_dir) do
      sh('bundle exec steep check')
    end
  end
end
