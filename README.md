# BLOCIPEDIA

Blocipedia is a Ruby on Rails app that allows users to create public and private Markdown-based wikis.
Users can upgrade their account by paying a membership, which allows them to view and create private wikis.



![Home Page](/app/assets/images/Inkedblocipediapage_LI2.jpg)



# Features

+ Users can create a standard account in order to create, edit, and collaborate on public wikis using Markdown syntax. Anyone can view public wikis.
+ Users can pay to upgrade their account to Premium in order to view and create private wikis.
+ Premium users can allow others to view and collaborate on the private wikis they create.
+ Premium users can downgrade their account back to Standard.
+ When a user downgrades his or her account, his or her private wikis will automatically become public.

# Setup and Configuration

**Languages and Frameworks:** Ruby on Rails and Bootstrap

**Ruby version 2.3.4**

**Databases:** SQLite (Test, Development), PostgreSQL (Production)

**Development Tools used:**

+ Pundit was used for authorization
+ Fake was used to seed the database.
+ Stripe was used for account payments.
+ Redcarpet was used to parse Markdown syntax.
+ Devise for user authentication.

**Setup:**

+ Environment variables were set using Figaro and are stored in config/application.yml (ignored by git).

+ The config/application.example.yml file illustrates how environment variables should be stored.

**To run Blocipedia locally:**

+ Clone the repository
+ Run bundle install
+ Create and migrate the SQLite database with `rake db:create` and `rake db:migrate`
+ Start the server using `rails server`
+ Run the app on `localhost:3000`


This app was created as part of the [Bloc](www.bloc.io) Full Stack Web Development course.