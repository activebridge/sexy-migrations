require 'sexymigrations'

namespace :do do
  desc 'Make all migrations look pretty'
  task :squash do
    SexyMigrations::Squash.new.call
  end
end
