namespace :db do
  desc 'Rebuild the db'
  task :x => :environment do
    Rake::Task["db:drop"].invoke
    Rake::Task["db:create"].invoke
    Rake::Task["db:migrate"].invoke
    Rake::Task["db:setup"].invoke
  end
end