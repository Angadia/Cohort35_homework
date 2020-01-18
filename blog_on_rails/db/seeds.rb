# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

PASSWORD = "supersecret"

# First destroy all records from table comments due to FK constraint.
Comment.destroy_all
# Then destroy all records from table posts.
Post.destroy_all
User.destroy_all

# Reset the primary key sequence to 1.
ActiveRecord::Base.connection.reset_pk_sequence!(:posts)
ActiveRecord::Base.connection.reset_pk_sequence!(:comments)
ActiveRecord::Base.connection.reset_pk_sequence!(:users)

super_user = User.create( 
  first_name: "Jon", 
  last_name: "Snow", 
  email: "js@winterfell.gov", 
  password: PASSWORD
)
puts Cowsay.say("Admin login with #{super_user.email} and password of '#{PASSWORD}'", :cow)

# Bulk insert of 50 fake posts.
Post.insert_all(
  50.times.map do
    {
      title: Faker::Hacker.say_something_smart,
      body: Faker::ChuckNorris.fact,
      created_at: Faker::Time.backward(days:365),
      updated_at: DateTime.now(),
      user_id: super_user.id
    }
  end
)

# Show how many fake posts are in the table posts.
puts Cowsay.say("Generated #{Post.count} posts using Faker.", :frogs)
puts Cowsay.say("Comments cleared out - #{Comment.count} comments.", :tux)
