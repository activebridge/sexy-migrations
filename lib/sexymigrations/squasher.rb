module SexyMigrations
  class Squasher
    def start
      read_schema
      select_create_table.select do |block|
      end
    end

    def read_schema
      @schema = File.open(schema_location).read
    end

    def schema_location
      File.join(SexyMigrations.root_path, 'db/schema.rb')
    end

    private

    def select_create_table
      @schema.scan(/create_table.*?end$/m)
    end

    def table_name
      @table_name = scan(/create_table.*?end$/m).select
    end
  end
end
