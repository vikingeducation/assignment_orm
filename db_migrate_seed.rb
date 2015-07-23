require './environment.rb'


#RUN THIS FILE ONLY ONCE





# MIGRATION SECTION

# this is another way to create
# a multi-line string
# Ruby terminates the string on a line that starts with SQL
# you can replace with any other characters you want
# as long as you follow the pattern
sql_string = <<SQL
  create table posts (
    id INTEGER PRIMARY KEY,
    title VARCHAR(30),
    body VARCHAR(32000))
SQL
# string was terminated with "SQL" on its own line


# runs the query
DB.execute(sql_string)




# SEEDS SECTION


titles = [ 'First Title',
           'Not the Second Title',
           "I hate titles",
           "Actually titles are pretty nice",
           "But this is the nicest title of all." ]

bodies = ['I am the very model of a modern major general',
          'I have information vegetable animal and mineral',
          'I can recite the kings of england in order categorical',
          'Eenie Meenie Miney Moe',
          'Lorem ipsum dolor sit amet is my new favorite band.']



titles.length.times do |i|

  insert_string = <<INSERTSTRING
    INSERT INTO posts(id, title, body)
    VALUES (null, "#{titles[i]}", "#{bodies[i]}");
INSERTSTRING

  DB.execute(insert_string)

end



# TESTING THIS OUT BY OUTPUTTING TO THE CLI
puts "SEEDED POSTS TABLE WITH:"
posts = DB.execute("SELECT posts.* FROM posts")
posts.each {|post| puts post.inspect }

