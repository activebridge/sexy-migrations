module SexyMigrations
  class Cleaner
    def start
      delete_unnecessary_migrations
    end

    def delete_unnecessary_migrations
      select_unnecessary_migrations
      delete_files
    end

    def migrations_folder
      File.join(SexyMigrations.root_path, ActiveRecord::Migrator.migrations_path)
    end

    private

    def select_unnecessary_migrations
      @other_migrations = Dir.glob(File.join(migrations_folder, "**/*")).select do |filename|
        !filename.match(/_create_/)
      end
    end

    def delete_files
      File.delete(*@other_migrations)
    end
  end
end
