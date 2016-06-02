module SexyMigrations
  class Squasher
    def start
      read_schema
      create_table.select do |selected_block|
        table_name(selected_block)
      end
    end

    def read_schema
      @schema = File.open(schema_location).read
    end

    def schema_location
      File.join(SexyMigrations.root_path, 'db/schema.rb')
    end

    private

    def create_table
      @schema.scan(/create_table.*?end$/m)
    end

    def table_name(selected_block)
      selected_block.scan(/create_table\s*"([^"]+)"/).dig(0,0)
    end
  end
end
