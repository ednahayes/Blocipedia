 require 'random_data'
 
 # Create Users
 5.times do
   user = User.create!(
   username: Faker::Internet.user_name,
   email:    Faker::Internet.email,
   password: Faker::Internet.password(8),
   confirmed_at: Time.now
   )
 end
 users = User.all 

 # Create admin
 
   admin = User.create!(
   username: Faker::Internet.user_name,
   email:    Faker::Internet.email,
   password: Faker::Internet.password(8),
   confirmed_at: Time.now,
   role: 'admin'
   )
 

 
# Create standard
 5.times do
   standard = User.create!(
   username: Faker::Internet.user_name,
   email:    Faker::Internet.email,
   password: Faker::Internet.password(8),
   confirmed_at: Time.now
   )
 end
 


# Create premium
 5.times do
   premium = User.create!(
   username: Faker::Internet.user_name,
   email:    Faker::Internet.email,
   password: Faker::Internet.password(8),
   confirmed_at: Time.now
   )
 end


 # Create Wikis
 15.times do
   wiki = Wiki.create!(
    user:   users.sample,   
    title:  Faker::Book.title,
    body:   Faker::Seinfeld.quote
   )
 end

 wikis = Wiki.all
 
 
 user = User.first
 user.update_attributes!(
   username: 'testuser',
   email: 'princessahe@hotmail.com', # replace this with your personal email
   password: 'helloworld'
  )
 
 puts "Seed finished"
 puts "#{Wiki.count} wikis created"
 puts "#{User.count} users created" 
