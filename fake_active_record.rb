module FakeActiveRecord
  class BASE
    # CLASS method on any
    # model object
    # that returns pluralized
    # version of (RAILS) class name
    # suitable for SQL expression
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


# inserted methods from "articles" table in warmup

    def self.all
      "SELECT self.table_name.*"
    end

    def self.find(id)
      unless @schema.id.exists?
        raise ArgumentError.new("id = #{id} does not exist")  
      end  
      "SELECT self.table_name.* 
        FROM self.table_name 
        WHERE self.table_name.id = :id
        LIMIT 1"
    end

    def self.last
      "SELECT self.table_name.*
        FROM self.table_name
        WHERE id = 1"
    end

    def self.first
      "SELECT self.table_name.*
        FROM self.table_name
        ORDER BY id DESC
        LIMIT 1"
    end

    def self.select(:column1, :column2)
      unless @schema.column1.exists?
        raise ArgumentError.new("column = #{column1} does not exist")
      end  
      unless @schema.column2.exists?
        raise ArgumentError.new("column = #{column2} does not exist")
      end 
      "SELECT self.table_name.column1, self.table_name.column2[, ...]
        FROM self.table_name"
    end

    def self.count
      "SELECT COUNT(self.table_name.*)
        From self.table_name"
    end

    def self.find([idn1, idn2, ...])
      unless [idn1, idn2, ...].include? @schema.id.exists?
          # check
      raise ArgumentError.new("idn1 = #{idn1} does not exist")  
      end  
      "SELECT self.table_name.* 
        FROM self.table_name 
        WHERE id IN (idn1, idn2, ...)"
    end

    def self.where(:column1 => "value", :column2 => "value")
      unless @schema[row[:column1]] = row["value"]
        raise ArgumentError.new("#{:column1} does not = #{"value"}")
      end  
      unless @schema[row[:column2]] = row["value"]
        raise ArgumentError.new("#{:column2} does not = #{"value"}")
      end  
      "SELECT self.table_name.* 
        FROM self.table_name 
        WHERE column1 = 'value'
        AND   column2 = 'value'"
    end

  end
end

