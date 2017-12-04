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


    def self.all
      DB.execute("SELECT * FROM #{self.table_name};")
    end


    def self.find(id)
      sql = "
      SELECT *
      FROM #{self.table_name}
      WHERE id = #{id}
      LIMIT 1;"

      DB.execute(sql)
    end


    def self.first
      sql = "
        SELECT *
        FROM #{self.table_name}
        ORDER BY id ASC
        LIMIT 1;"
      DB.execute(sql)
    end


    def self.last
      sql = "
        SELECT *
        FROM #{self.table_name}
        ORDER BY id DESC
        LIMIT 1;"
      DB.execute(sql)
    end


    def self.select(*args)
      columns = args.join(', ')
      sql = "
        SELECT #{columns}
        FROM #{self.table_name};"
      DB.execute(sql)
    end


    def self.count
      sql = "
        SELECT COUNT(*)
        FROM #{self.table_name};"
      DB.execute(sql)
    end


    def self.find(*args)
      ids = args.join(', ')

      sql = "
        SELECT *
        FROM #{self.table_name}
        WHERE id IN (#{ids});"
      DB.execute(sql)
    end


    def self.where(params = {})
      args = params.map do |k, v|
        "#{k} = #{v}"
      end.join("\n AND ")

      sql = "SELECT * FROM #{self.table_name} WHERE " + args + ";"
      DB.execute(sql)
    end

    def self.create(params = {})
      columns = params.keys.join(", ")
      values = params.values.map do |v|
        (v.is_a? Integer) ? v : "'#{v}'"
      end.join(", ")

      sql = "
        INSERT INTO #{self.table_name} (#{columns})
        VALUES (#{values});"
      DB.execute(sql)
    end


  end
end

