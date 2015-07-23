# THIS FILE IS THE BASIS OF EVERYTHING
# It sets up a database connection in the
# global space so that everything else
# can talk to it
# and it requires your
# FakeActiveRecord module so you can use it


require 'sqlite3'
DB = SQLite3::Database.new "test.db"


# this lets you create model objects
require './fake_active_record.rb'

# requires the model object you're working with
require './post.rb'