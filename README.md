# README

# Tables

* Shool
-schools
has_many :childminders users(childminders)
has_many children

* Posting
- user_schools
belongs_to user(childminder)
belongs_to school

* User
- users
has_many children
has_many children, thorugh: :child_childminders
has_many sessions as childminder(user)
has_many session_bookings as parent(user)


* Child
- children
belongs_to :parent

<!-- * ChildChildminder
- child_childminders
belongs_to :user as childminder
belongs_to child -->

* Session
- sessions
belongs_to :user childminder


* SessionBooking
- session_bookings
belongs_to :session
belongs_to :parent
belongs_to :child






# Usecases


This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
