require "sexymigrations/version"
require "rake"
require "rails"

import File.join(File.dirname(__FILE__), 'tasks', 'db.rake')

module SexyMigrations
  class Squash
    def start
      delete_unnecessary_migrations
      read_schema
    end

    def delete_unnecessary_migrations
      select_unnecessary_migrations
      delete_files
    end

    def read_schema
      @schema = File.open(schema_location).read
    end

    private

    def select_create_table
      scan(/create_table.*?end$/m).select
    end

    def select_unnecessary_migrations
      @other_migrations = Dir.glob(File.join(migrations_folder, "**/*")).select { |filename| !filename.match(/_create_/) }
    end

    def delete_files
      File.delete(*@other_migrations)
    end

    def schema_location
      File.join(root_path, 'db/schema.rb')
    end

    def migrations_folder
      File.join(root_path, ActiveRecord::Migrator.migrations_path)
    end

    def root_path
      Rails.root
    end
  end
end
