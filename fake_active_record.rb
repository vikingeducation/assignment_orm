require 'pry-byebug'

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

    def self.find(*id)
      q = Array.new(id.size){ '?' }.join(', ')
      statement = "SELECT #{table_name}.* FROM #{table_name} WHERE #{table_name}.id IN (#{q})"
      executor(statement, id)
    end

    def self.first
      DB.execute("SELECT #{table_name}.* FROM #{table_name} ORDER BY #{table_name}.id LIMIT 1")
    end

    def self.last
      DB.execute("SELECT #{table_name}.* FROM #{table_name} ORDER BY #{table_name}.id DESC LIMIT 1")
    end

    def self.select(*cols)
      if cols.empty?
        cols = "#{table_name}.*"
      else
        cols = cols.map do |el|
          raise "Column #{el} does not exist" unless columns.include?(el.to_s)
          "#{table_name}." << el.to_s
        end
      end
      DB.execute("SELECT #{cols.join(', ')} FROM #{table_name}")
    end

    def self.count
      DB.execute("SELECT COUNT(*) FROM #{table_name}")
    end

    def self.where(params={})
      schema
      unless params.empty?
        keys = []
        params.each do |k, v|
          k = k.to_s
          raise "Column #{k} does not exist" unless columns.include?(k)
          keys << k + '= ?'
        end
        where = 'WHERE ' << keys.join(' AND ')
      end
      executor("SELECT #{table_name}.* FROM #{table_name} #{where}", params.values)

    end

    def self.create(cols={})
      raise "Nothing to create!" if cols.empty?
      keys = cols.keys.each { |k|  raise 'Column does not exist' unless columns.include?(k.to_s) }.join(', ')
      statement = "INSERT INTO #{table_name} (#{keys}) VALUES (#{Array.new(cols.values.size, '?').join(', ')})"
      executor(statement, cols.values)
      puts "The following post was created:"
      print last
    end

    private

    def self.executor(statement, vars)
      begin

        s = DB.prepare statement
        s.bind_params *(vars)
        rows = s.execute
        rows.to_a

      rescue SQLite3::Exception => e

        puts "Exception occurred"
        puts e

      end

    end
  end





end
