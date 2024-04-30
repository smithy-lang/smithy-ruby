namespace :docs do
  desc 'Build yardocs for hearth'
  task :hearth do
    sh('bundle exec yardoc hearth/lib')
  end
end
