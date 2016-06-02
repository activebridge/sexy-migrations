module SexyMigrations
  class Squasher
    def start
      read_schema
      create_table.select do |selected_block|
        find_table_name(selected_block)
        rewrite_migration(selected_block)
      end
    end

    def rewrite_migration(selected_block)
      File.open(matched_migration, 'w') do |f|
        append_starting_info(f)
        f.write("  ")
        f.write(selected_block)
        f.puts
      end
    end

    def append_starting_info(file)
      file.puts("class Create#{@table_name} < ActiveRecord::Migration\n\tdef change")
    end

    def read_schema
      @schema = File.open(schema_location).read
    end

    def schema_location
      File.join(SexyMigrations.root_path, 'db/schema.rb')
    end

    private

    def matched_migration
      Dir.glob(File.join(SexyMigrations.migrations_folder, "**/*")).select { |f| f.match("#{@table_name}") }.first
    end

    def create_table
      @schema.scan(/create_table.*?end$/m)
    end

    def find_table_name(selected_block)
      @table_name = selected_block.scan(/create_table\s*"([^"]+)"/).dig(0,0)
    end
  end
end
