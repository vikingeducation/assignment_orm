class Article

  class << self

    def all
      "SELECT * FROM articles"
    end

    def find(*ids)
      ids_str = "(#{ids.join(", ")})"
      "SELECT * FROM articles WHERE articles.id IN #{ids_str}"
    end

    def first
      "SELECT * FROM articles LIMIT 1"
    end

    def last
      "SELECT * FROM articles ORDER BY articles.id DESC LIMIT 1"
    end

    def select(*cols)
      col_str = cols.map { |c| "articles.#{c}" }.join(", ")
      "SELECT #{col_str} FROM articles"
    end

    def count
      "SELECT COUNT(articles.*) FROM articles"
    end

    def where(pairs={})
      conditions = pairs.map { |p| "#{p[0]}=#{p[1]}" }.join(" AND ")
      "SELECT * FROM articles WHERE #{conditions}"
    end

  end

end