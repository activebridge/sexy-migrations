module SexyMigrations
  class Cleaner
    def start
      delete_unnecessary_migrations
    end

    def delete_unnecessary_migrations
      select_unnecessary_migrations
      delete_files
      clean_missing_migrations
    end

    private

    def select_unnecessary_migrations
      @other_migrations = Dir.glob(File.join(SexyMigrations.migrations_folder, '**.rb')).select do |filename|
        !filename.match(/_create_/)
      end
    end

    def delete_files
      File.delete(*@other_migrations)
    end

    def clean_missing_migrations
      versions = @other_migrations.map { |path| path.match(/(\d+)_/).captures.first }
      ActiveRecord::SchemaMigration.where(version: versions).delete_all
    end
  end
end
