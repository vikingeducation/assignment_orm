# your code goes here
class Article
  def self.all
    "SELECT articles.* FROM articles"
  end


  def self.find(*id)
    id = id.join(', ')
    "SELECT articles.* FROM articles WHERE articles.id IN (#{id})"
  end

  def self.first
    "SELECT articles.* FROM articles ORDER articles.id LIMIT 1"
  end

  def self.last
    "SELECT articles.* FROM articles ORDER articles.id DESC LIMIT 1"
  end

  def self.select(*cols)
    cols = cols.empty? ? 'articles.*' : cols.map{|el| 'articles.' << el.to_s }.join(', ')
    "SELECT #{cols} FROM articles"
  end

  def self.count
    "SELECT COUNT(*) FROM articles"
  end

  def self.where(params={})
    unless params.empty?
      where = 'WHERE '
      where << params.map {|k, v| k.to_s + '=' + v}.join(' AND ')
    end
    "SELECT articles.* FROM articles #{where}"
  end

end
