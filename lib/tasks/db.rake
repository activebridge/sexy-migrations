require 'sexymigrations'

namespace :db do
  desc 'Make migrations look pretty'
  task :squash do
    SexyMigrations::Squash.new.call
  end
end
