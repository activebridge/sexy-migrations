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

  def root_path
    Rails.root
  end
end
