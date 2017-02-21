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
      DB.execute("SELECT #{self.table_name}.* FROM #{self.table_name}")
    end

    def self.find(*id)
      id = id.join(', ')
      DB.execute("SELECT #{self.table_name}.* FROM #{self.table_name} WHERE #{self.table_name}.id IN (#{id})")
    end

    def self.first
      DB.execute("SELECT #{self.table_name}.* FROM #{self.table_name} ORDER BY #{self.table_name}.id LIMIT 1")
    end

    def self.last
      DB.execute("SELECT #{self.table_name}.* FROM #{self.table_name} ORDER BY #{self.table_name}.id DESC LIMIT 1")
    end

    def self.select(*cols)
      self.schema
      if cols.empty?
        cols = "#{self.table_name}.*"
      else
        cols = cols.map do |el|
          el = el.to_s
          raise 'Column does not exist' if @schema[el].nil?
          "#{self.table_name}." << el
        end
        cols = cols.join(', ')
      end
      DB.execute("SELECT #{cols} FROM #{self.table_name}")
    end

    def self.count
      DB.execute("SELECT COUNT(*) FROM #{self.table_name}")
    end

    def self.where(params={})
      self.schema
      unless params.empty?
        where = 'WHERE '
        # where << params.map {|k, v| k.to_s + '=' + v}.join(' AND ')
        params =  params.map do |k, v|
          k = k.to_s
          raise 'Column does not exist' if @schema[k].nil?
          k << " = '" + v + "'"
        end
        where << params.join(' AND ')
      end
      DB.execute("SELECT #{self.table_name}.* FROM #{self.table_name} #{where}")
    end

    def self.create(cols={})
      self.schema
      raise "Nothing to create!" if cols.empty?
      keys, vals = [], []
      cols.each do |k, v|
        k = k.to_s
        raise 'Column does not exist' if @schema[k].nil?
        keys << k
        vals << "'" + v.to_s + "'"
      end
      keys = keys.join(', ')
      vals = vals.join(', ')
      DB.execute("INSERT INTO #{self.table_name} (#{keys})
      VALUES (#{vals})")
      puts "The following post was created:"
      print self.last
    end


  end
end
