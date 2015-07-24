module FakeActiveRecord
  class BASE

    include Article

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
        "SELECT * FROM #{self.table_name}"
    end

    def self.find(*array_id)
      "SELECT * FROM #{self.table_name} WHERE article.id IN (#{array_id.join(", ")})"
    end

    def self.first
      "SELECT * FROM #{self.table_name} ORDER BY id LIMIT 1"
    end

    def self.last
      "SELECT * FROM #{self.table_name} ORDER BY id DESC LIMIT 1"
    end

    def self.select(*arg)
      raise "Column does not exist" unless arg.all? { |col| self.columns.include?(col)  }
      'SELECT #{arg.join(", )} FROM #{self.table_name}'
    end


    def self.count
      'SELECT COUNT(*) FROM #{self.table_name}'
    end

    def self.where(*columns)
      raise "Column does not exist" unless columns.all? { |col| self.columns.include?(col)  }
      query = []
      columns.each do |key, value|
        query << "#{key} = #{value}"
      end

      'SELECT * FROM #{self.table_name} WHERE #{query.join(" AND ")}'
    end

  end
  
end

