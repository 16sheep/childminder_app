# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.firs
School.create(name: "City Of London School", address: "123 Barbican")
School.create(name: "Westminister School", address: "123 Mayfair")
School.create(name: "Lowther Primary School", address: "54 Washington Road")
School.create(name: "St. Pauls", address: "34 Castelnau")
School.create(name: "Barnes Primary School", address: "12 Whiteheart Lane")

Posting.create(school_id: 2, user_id:1)
Posting.create(school_id: 4, user_id:2)
Posting.create(school_id: 5, user_id:1)
Posting.create(school_id: 2, user_id:3)
Posting.create(school_id: 3, user_id:4)
Posting.create(school_id: 1, user_id:2)
Posting.create(school_id: 2, user_id:4)

User.create(name: "Lula", email: "lula@gmail.com", password_digest: "xxxxx")
User.create(name: "Tom", email: "tom@gmail.com", password_digest: "xxxxx")
User.create(name: "Tim", email: "tim@gmail.com", password_digest: "xxxxx")
User.create(name: "Lola", email: "lola@gmail.com", password_digest: "xxxxx")

SessionBooking.create(user_id: 1, availability_id: 2, child_id: 1)
SessionBooking.create(user_id: 2, availability_id: 4, child_id: 3)
SessionBooking.create(user_id: 3, availability_id: 1, child_id: 6)
SessionBooking.create(user_id: 4, availability_id: 3, child_id: 7)
SessionBooking.create(user_id: 4, availability_id: 3, child_id: 8)

Child.create(name: "Mona", age: 5, user_id: 1, school_id: 1)
Child.create(name: "Anna", age: 7, user_id: 2, school_id: 2)
Child.create(name: "Tina", age: 6, user_id: 2, school_id: 3)
Child.create(name: "Sara", age: 10, user_id: 2, school_id: 3)
Child.create(name: "Jim", age: 5, user_id: 3, school_id: 5)
Child.create(name: "Ray", age: 9, user_id: 3, school_id: 5)
Child.create(name: "Max", age: 8, user_id: 4, school_id: 4)
Child.create(name: "Leo", age: 5, user_id: 4, school_id: 1)
