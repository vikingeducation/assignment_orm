module FakeActiveRecord
  class BASE
    # CLASS method on any
    # model object
    # that returns pluralized
    # version of class name

    class << self

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
        "SELECT * FROM #{table_name}"
      end

      def find(*ids)
        ids_str = "(#{ids.join(", ")})"
        "SELECT * FROM #{table_name} WHERE #{table_name}.id IN #{ids_str}"
      end

      def first
        "SELECT * FROM #{table_name} LIMIT 1"
      end

      def last
        "SELECT * FROM #{table_name} ORDER BY #{table_name}.id DESC LIMIT 1"
      end

      def select(*cols)
        col_str = cols.map { |c| "#{table_name}.#{c}" }.join(", ")
        "SELECT #{col_str} FROM #{table_name}"
      end

      def count
        "SELECT COUNT(#{table_name}.*) FROM #{table_name}"
      end

      def where(pairs={})
        conditions = pairs.map { |p| "#{p[0]}=#{p[1]}" }.join(" AND ")
        "SELECT * FROM #{table_name} WHERE #{conditions}"
      end


    end



    # YOUR CODE GOES HERE





  end
end

