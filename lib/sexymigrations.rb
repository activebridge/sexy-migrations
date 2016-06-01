require "sexymigrations/version"
require 'rake'

import File.join(File.dirname(__FILE__), 'tasks', 'db.rake')

module SexyMigrations
  class Squash
    def call
    end
  end
end
