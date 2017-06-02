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

    # YOUR CODE GOES HERE
    def self.all
      "SELECT self.talbe_name.*"
      DB.execute(Post.table_name)
    end

    def self.find(id)
      "SELECT id
      FROM self.talbe_name"
      DB.execute(Post.table_name)
    end

    def self.first
      "SELECT self.talbe_name.*
      LIMIT 1"
      DB.execute(Post.table_name)
    end

    def self.last
      "SELECT self.talbe_name.*
      LIMIT 1
      ORDER DESC"
      DB.execute(Post.table_name)
    end

    def self.select(params)
      "SELECT params
      FROM self.talbe_name"
      if schema !include(params)
        raise "error"
      end
      DB.execute(Post.table_name)
    end

    def self.count
      "SELECT COUNT(*)
      FROM self.talbe_name"
      DB.execute(Post.table_name)
    end

    def self.ids(id_arr)
      id_arr.each do |id|
        "SELECT id
        FROM self.talbe_name"
        if schema !include(params)
          raise "error"
        end
      end
      DB.execute(Post.table_name)
    end

    def self.where(param_hash)
      "SELECT self.talbe_name.*
      FROM self.talbe_name
      WHERE param_hash"
      if schema !include(params)
        raise "error"
      end
      DB.execute(Post.table_name)
    end





  end
end
