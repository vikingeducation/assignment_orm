class Article
  def self.all
    "SELECT articles.*"
  end

  def self.find(id)
    "SELECT id
    FROM articles"
  end

  def self.first
    "SELECT articles.*
    LIMIT 1"
  end

  def self.last
    "SELECT articles.*
    LIMIT 1
    ORDER DESC"
  end

  def self.select(params)
    "SELECT params
    FROM articles"
  end

  def self.count
    "SELECT COUNT(*)
    FROM articles"
  end

  def self.ids(id_arr)
    id_arr.each do |id|
      "SELECT id
      FROM articles"
    end
  end

  def self.where(param_hash)
    "SELECT articles.*
    FROM articles
    WHERE param_hash"
  end
end
