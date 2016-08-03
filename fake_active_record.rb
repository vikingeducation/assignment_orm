module FakeActiveRecord
  class BASE

    class << self

      # Create table.
      def init
        sql_string = <<SQL
          create table #{table_name} (
            id INTEGER PRIMARY KEY,
            title VARCHAR(30),
            body VARCHAR(32000))
SQL
        DB.execute(sql_string)
      end

      def create(pairs={})
        cols = "#{pairs.keys.join(", ")}"
        vals = "#{pairs.values.map{|v| "\'#{v}\'"}.join(", ")}"
          insert_string = <<INSERTSTRING
    INSERT INTO #{table_name} (#{cols})
    VALUES (#{vals});
INSERTSTRING
          DB.execute(insert_string)
      end

      def table_name
        "#{self.name.downcase}s"
      end


      # gives you a hash of {column_name: column_type }
      # for your table
      def schema
        return @schema if @schema

        @schema = {}

        # example:
        # If you're a Post
        # runs DB.table_info("posts")
        DB.table_info(table_name) do |row|
          @schema[row["name"]] = row["type"]
        end

        @schema
      end

      # convenience wrapper for your schema's column names
      def columns
        schema.keys
      end

      def all
        DB.execute "SELECT * FROM #{table_name}"
      end

      def find(*ids)
        ids_str = "(#{ids.join(", ")})"
        DB.execute "SELECT * FROM #{table_name} WHERE #{table_name}.id IN #{ids_str}"
      end

      def first
        DB.execute "SELECT * FROM #{table_name} LIMIT 1"
      end

      def last
        DB.execute "SELECT * FROM #{table_name} ORDER BY #{table_name}.id DESC LIMIT 1"
      end

      def select(*cols)
        raise if cols.none? { |c| columns.include?(c.to_s) }
        col_str = cols.map { |c| "#{table_name}.#{c}" }.join(", ")
        DB.execute "SELECT #{col_str} FROM #{table_name}"
      end

      def count
        DB.execute "SELECT COUNT(*) FROM #{table_name}"
      end

      def where(pairs={})
        raise if pairs.keys.none? { |c| columns.include?(c.to_s) }
        conditions = pairs.map { |p| "#{p[0]}=\'#{p[1]}\'" }.join(" AND ")
        DB.execute "SELECT * FROM #{table_name} WHERE #{conditions}"
      end


    end

  end
end
