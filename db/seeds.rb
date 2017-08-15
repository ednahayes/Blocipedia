 require 'random_data'
 
 # Create Users
 5.times do
   User.create!(
   username: RandomData.random_word,
   email:    RandomData.random_email,
   password: RandomData.random_sentence
   )
 end
 users = User.all 


 # Create Wikis
 5.times do
   wiki = Wiki.create!(
    user:   users.sample,   
    title:  RandomData.random_sentence,
    body:   RandomData.random_paragraph
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