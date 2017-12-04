class Article

  # 1. Article.find(id)
  def self.find(id)
  end


  # 2. Article.first and Article.last
  def self.first
  end

  def self.last
  end


  # 3. Article.select(:column1, :column2)
  # Note that this can take any number of parameters.
  def self.select
  end


  # 4. Article.count
  def self.count
  end

  # 5. Extend Article.find to also take an array of ids
  def self.find(ids)
  end

  # 6. Article.where(:column1 => "value", :column2 => "value")
  # Note that this takes a hash of parameters, and it essentially
  # joins each constraint with an AND.
  def self.where
  end

end
