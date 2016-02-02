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
      DB.execute("SELECT #{table_name}.* FROM #{table_name}")
    end

    def self.find(*args)
      stm = DB.prepare("SELECT #{table_name}.*  FROM #{table_name} WHERE id IN (" + Array.new(args.size, "?").join(",") + ")")

      stm.bind_params *args
      stm.execute.to_a
    end

    def self.first
      DB.execute("SELECT #{table_name}.* FROM #{table_name} ORDER BY #{table_name}.id LIMIT 1")[0]
    end

    def self.last
      DB.execute("SELECT #{table_name}.* FROM #{table_name} ORDER BY #{table_name}.id DESC LIMIT 1")[0]
    end

    def self.select(*args)
      stm = DB.prepare("SELECT " + Array.new(args.size, "?").join(",") + "FROM #{table_name}")

      stm.bind_params *args
      stm.execute.to_a
    end

    def self.count
      DB.execute("SELECT COUNT(*) FROM #{table_name}")[0][0]
    end

    def self.where(opts)
      opts.keys.each do |opt|
        return false unless columns.include?(opt.to_s)
      end
      stm = DB.prepare("SELECT #{table_name}.* FROM #{table_name} WHERE " + opts.to_a.map { |key, value| "#{key} = ?"}.join(" AND "))
      stm.bind_params *(opts.values)
      stm.execute.to_a
    end

    def self.create(opts)

      insert_string = <<INSERTSTRING
        INSERT INTO #{table_name} (#{opts.keys.join(", ")})
        VALUES (#{opts.values.map { |val| "'#{val}'" }.join(", ")});
INSERTSTRING
      DB.execute(insert_string)
    end


  end
end
