require "sexymigrations/version"
require 'rake'

import File.join(File.dirname(__FILE__), 'tasks', 'db.rake')

module SexyMigrations
  class Squash
    def call
    end

    private

    def schema_location
      File.join(root_path, 'db/schema.rb')
    end

    def migrations_folder
      File.join(root_path, "db/migrate/")
    end

    def root_path
      Dir.pwd
    end
  end
end
