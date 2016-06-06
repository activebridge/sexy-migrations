module SexyMigrations
  class Squasher
    def start
      read_schema
      create_table.select do |selected_block|
        find_table_name(selected_block)
        rewrite_migration(selected_block)
        append_foreign_keys_and_indexes
        append_ending_info
      end
      correct_schema_version
      reset_database
    end

    def rewrite_migration(selected_block)
      File.open(matched_migration, 'w') do |f|
        append_starting_info(f)
        f.write('  ')
        f.write(selected_block)
        f.puts
      end
    end

    def append_starting_info(file)
      file.puts("class Create#{@table_name.camelize} < ActiveRecord::Migration\n\tdef change")
    end

    def append_ending_info
      File.open(matched_migration, 'a') do |f|
        f.write("  end\nend")
      end
    end

    def correct_schema_version
      get_schema_version
      set_last_version
    end

    def read_schema
      @schema = File.open(schema_location).read
    end

    def schema_location
      File.join(SexyMigrations.root_path, 'db/schema.rb')
    end

    def reset_database
      system 'rake db:migrate'
    end

    private

    def append_foreign_keys_and_indexes
      File.foreach(schema_location) do |line|
        if line =~ /add_index "#{@table_name}"|add_foreign_key "#{@table_name}"/
          File.open(matched_migration, 'a') do |f|
            f.puts
            f.write(line)
          end
        end
      end
    end

    def matched_migration
      Dir.glob(File.join(SexyMigrations.migrations_folder, '**/*')).select { |f| f.match(@table_name.to_s) }.first
    end

    def create_table
      @schema.scan(/create_table.*?end$/m)
    end

    def find_table_name(selected_block)
      @table_name = selected_block.scan(/create_table\s*"([^"]+)"/).dig(0, 0)
    end

    def get_schema_version
      @schema_version = @schema.match(/version: (\d+)/).captures.first
    end

    def set_last_version
      Dir.foreach(SexyMigrations.migrations_folder) do |item|
        @matched_version = true if item.match("#{@schema_version}")
      end

      if !@matched_version
        migration = Dir.glob(Rails.root.join('db/migrate/**.*')).max
        @appropriate_version = migration.match(/(\d+)_/).captures.first

        replace_text
      end
    end

    def replace_text
      text = File.open(schema_location).read
      new_content = text.gsub(/version: (\d+)/, @appropriate_version)
      File.open(schema_location, "w") {|file| file.puts new_content }
    end
  end
end
