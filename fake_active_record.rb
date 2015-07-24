module FakeActiveRecord
  class BASE
    # CLASS method on any
    # model object
    # that returns pluralized
    # version of class name
    def self.table_name
      "#{self.name.downcase}s"
    end


    # gives you a hash of {column_name: column_type }
    # for your table
    def self.schema
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
    def self.columns
      schema.keys
    end

  end



    # YOUR CODE GOES HERE
    class Article
    # notice that this is a CLASS method
      def self.all
          "SELECT articles.*"
      end

      def self.find(id)
        "SELECT * FROM articles WHERE article.id = id LIMIT 1"
      end

      def self.first
        "SELECT * FROM articles ORDER BY id LIMIT 1"
      end

      def self.last
        "SELECT * FROM articles ORDER BY id DESC LIMIT 1"
      end
        
        
      def self.select(*arg)
        'SELECT #{arg.join(", )} FROM articles'
      end

    end





  
end

