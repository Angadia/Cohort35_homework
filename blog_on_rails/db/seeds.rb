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
  password: PASSWORD,
  is_admin: true
)
puts Cowsay.say("Admin login with #{super_user.email} and password of '#{PASSWORD}'", :cow)

10.times do |n|
  User.create( 
    first_name: Faker::Name.first_name, 
    last_name: Faker::Name.last_name,  
    # email: "#{first_name.downcase}.#{last_name.downcase}@example.com", 
    email: "email#{n}@example.com", 
    password: PASSWORD 
  )
end 
    
users = User.all
puts Cowsay.say("Created #{users.count} users", :tux) 
puts Cowsay.say("Users email are #{(users.map do |user| user.email end).join(', ')}", :kitty)

20.times.map do
  user = users.sample
  p = Post.create(
    title: Faker::Hacker.say_something_smart,
    body: Faker::Lorem.paragraph_by_chars(number: 75, supplemental: false),
    created_at: Faker::Date.backward(days:365 * 5),
    updated_at: Faker::Date.backward(days:365 * 3),
    user_id: user.id
  )
  if p.valid?
    p.comments = rand(0..5).times.map do
      user = users.sample
      Comment.new(
        body: Faker::GreekPhilosophers.quote,
        created_at: Faker::Date.backward(days:365 * 2),
        updated_at: Faker::Date.backward(days:365 * 1),
        user_id: user.id
      )
    end
  else
    puts "Failed to persist Post instance due to #{p.errors.full_messages.join(', ')}"      
  end
end
  
puts Cowsay.say("Generated #{Post.count} posts using Faker.", :frogs)
puts Cowsay.say("Generated #{Comment.count} comments using Faker.", :tux)
