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


def seed_posts
  10.times do |i|
    Post.create({id: "#{i}", title: "Post ##{i}", body: "This is a post."})
  end
end

def test
  DB.execute("drop table #{Post.table_name}")
  Post.init
  seed_posts
  puts "ID 3, 4 and 5:"
  p Post.find(3,4,5)
  puts
  puts "ALL POSTS: "
  p Post.all
  puts
  puts "LAST POST: "
  p Post.last
  puts "There are #{Post.count} posts in the db."
  puts
  puts "SELECT TITLE: "
  p Post.select(:id, :title)
  puts "WHERE: "
  p Post.where({title: "Post #3"})
end

test