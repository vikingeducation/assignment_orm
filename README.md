# README

Mimicking ActiveRecord project from Viking Code School


Anne Richardson


## Setting up this project

1. Fork and clone
2. bundle
3. run `ruby db_migrate_seed.rb`
4. open irb
5. load the project files by pasting this into irb:

```
require 'sqlite3'
require './fake_active_record.rb'
require './post.rb'

DB = SQLite3::Database.new "test.db"
```

6. Access the post class methods as you normally would a class method. Ex:

```
Post.all
```
