## Writing Your Own ORM (kinda)

You've converted SQL to AR and AR to SQL. Now it's time to see just a little bit how the whole package fits together.



## Getting Started

1. Fork [this GitHub repo](https://github.com/vikingeducation/assignment_orm) and pull it down to your local machine.
2. Add your name to the README and begin.
3. `bundle install`
4. run `bundle exec ruby db_migrate_seed.rb` which seeds your database


### Warmup: SQL translator

Before you dig into the code we've already provided, we want you to create methods that look like ActiveRecord methods and return a string of SQL code for an Article class.

Here's the simplest possible example, so you can follow it:

```
class Article
    # notice that this is a CLASS method
    def self.all
        "SELECT articles.*"
    end
end

# Article.all
# => "SELECT articles.*"
```

We want you to create a handful more methods on this model, that work like the appropriate ActiveRecord queries.

1. **Article.find(id)**
2. **Article.first and Article.last**
3. **Article.select(:column1, :column2)** -- Note that this can take any number of parameters.
4. **Article.count**
5. **Extend Article.find to also take an array of id's**
6. **Article.where(:column1 => "value", :column2 => "value")** -- Note that this takes a hash of parameters, and it essentially joins each constraint with an AND.


### Familiarize Yourself

Now, take a look through the database we have created for you. The suggested order to understand what's going on is:

1. `environment.rb` requires everything you need to work with your database
2. `db_migrate_seed.rb` is a good example of working with the database, even if you won't be running it again.
3. `fake_active_record.rb` is the module that lets classes inherit methods to work with a database. You're going to be filling it in a lot more shortly.

Pay attention to the way that the semi-global `DB` variable is given the command to `execute` a string of SQL in the seed migration file. That's not remotely safe for production(no protection from SQL injection), but it certainly works in this case.

Also, note that our copy of ActiveRecord makes it possible in `post.rb` just to inherit its class methods from `FakeActiveRecord::BASE`. One very important method for you to realize is the `self.table_name` method, which can be used everywhere in your queries.


### Add to FakeActiveRecord::BASE

1. Now take your Article methods and add them on to your BASE class, but DRY them up with `self.table_name` so they can work on any class that inherits them.
2. Make these methods raise errors if the columns referenced aren't in the schema. (you have help in the existing methods for that)
3. Rewrite these methods to actually run their queries with `DB.execute`, test them out by using them on Post in the console, and see if they work.
4. Using the examples in `db_migrate_seed.rb`, write a `.create` method on your BASE class that takes an arbitrary number of column values as options.
5. **(Optional):** Protect against SQL injection by [reading this tutorial](http://zetcode.com/db/sqliteruby/bind/) and replacing all your direct database executions with binding parameters and executing within a begin/rescue/end. You probably want to keep this DRY by having a private method with this functionality getting called by all the other of your methods.


### Advanced: Start Chaining Queries

1. 


### Wrapping Up

Commit everything and push your code up to GitHub.

