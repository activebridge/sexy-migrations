require "sexymigrations/version"
require 'rake'

import File.join(File.dirname(__FILE__), 'tasks', 'db.rake')

module SexyMigrations
  class Squash
    def call
      delete_unnecessary_migrations
    end

    def delete_unnecessary_migrations
      other_migrations = select_unnecessary_migrations
      delete_files(other_migrations)
    end

    private

    def select_unnecessary_migrations
      Dir.glob(File.join(migrations_folder, "**/*")).select {|filename| !filename.match(/_create_/) }
    end

    def delete_files(other_migrations)
      File.delete(*other_migrations)
    end

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
