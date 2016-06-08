require 'sexymigrations'

namespace :db do
  desc 'Make migrations look pretty'
  task squash: :environment do
    SexyMigrations.call
  end
end
