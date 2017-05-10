# Mimicking ActiveRecord

# Warmup: SQL translator

class Article
    # notice that this is a CLASS method
    
    def self.all
      "SELECT articles.*"
    end

    def self.find(id)
      SELECT articles.* 
        FROM articles 
        WHERE articles.id = :id
        LIMIT 1
    end

    def self.last
      SELECT articles.*
        FROM articles
        WHERE id = 1
    end

    def self.first
      SELECT articles.*
        FROM articles
        ORDER BY id DESC
        LIMIT 1
    end

    def self.select(:column1, :column2)
      SELECT articles.column1, articles.column2[, ...]
        FROM articles
    end

    def self.count
      SELECT COUNT(articles.*)
        From articles
    end

    def self.find([idn1, idn2, ...])
      SELECT articles.* 
        FROM articles 
        WHERE id IN (idn1, idn2, ...)
    end

    def self..where(:column1 => "value", :column2 => "value")
      SELECT articles.* 
        FROM articles 
        WHERE column1 = "value"
        AND   column2 = "value"
    end

end

