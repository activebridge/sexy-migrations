require "rake"
require "rails"

import File.join(File.dirname(__FILE__), 'tasks', 'db.rake')

module SexyMigrations
  extend self

  autoload :Cleaner, 'sexymigrations/cleaner'
  autoload :Squasher, 'sexymigrations/squasher'

  def call
    Cleaner.new.start
    Squasher.new.start
  end

  def migrations_folder
    File.join(root_path, ActiveRecord::Migrator.migrations_path)
  end

  def root_path
    Rails.root
  end
end
