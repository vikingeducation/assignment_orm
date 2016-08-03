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

    end



    # YOUR CODE GOES HERE





  end
end

