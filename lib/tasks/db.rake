require 'sexymigrations'

namespace :db do
  desc 'Make migrations look pretty'
  task :squash do
    SexyMigrations.call
  end
end
