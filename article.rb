class Article
  # notice that this is a CLASS method
  def self.all
    "SELECT articles.*"
  end

  def self.find(*args)
    "SELECT articles.* WHERE id IN (" + args.map(&:to_s).join(", ") + ")"
  end

  def self.first
    "SELECT articles.* ORDER BY articles.id LIMIT 1"
  end

  def self.last
    "SELECT articles.* ORDER BY articles.id DESC LIMIT 1"
  end

  def self.select(*args)
    "SELECT " + args.map { |arg| "article.#{arg}" }.join(", ")
  end

  def self.count
    "SELECT COUNT(articles.*)"
  end

  def self.where(opts)
    "SELECT articles.* WHERE " + opts.to_a.map { |key, value| "#{key}='#{value}'"}.join(" AND ")
  end

end

game = Article.new
p Article.where(first_name: "john", last_name: "doe")
