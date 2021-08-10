# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(email: 'johomb@gmail.com', password: 'johomb', password_confirmation: 'johomb')

Profile.create(first_name: 'Darrell', last_name: 'Hernandez', title: 'Telecommunications Specialist',
               company: 'Olympic Sports', phone: '513-464-2003', address: '2039 Goldie Lane', city: 'Dayton', state: 'OH', zip_code: '45402', user_id: '1')

Note.create(
  content: 'First Call with John was very pleasant. Their company is going through a merger that should be completed in a couple of months.', user_id: 1
)

Note.create(content: 'John was introduced by Audrey at the convention.', user_id: 1)

Note.create(content: 'Business dinner with John @ Red Lobster on September 23, 2017 at 07:00 pm.', user_id: 1)

Contact.create(first_name: 'Frank', last_name: 'Smith', title: 'Visual Designer', company: 'Tesla', user_id: 1)

Contact.create(first_name: 'Erik', last_name: 'Brooks', title: 'VP of Software', company: 'Google', user_id: 1)

Contact.create(first_name: 'Dianna', last_name: 'Philipsson', title: 'Information Systems Manager', company: 'Nike',
               user_id: 1)

Contact.create(first_name: 'Edward', last_name: 'Wells', title: 'Web Strategist', company: 'Apple', favorite: true,
               user_id: 1)

Contact.create(first_name: 'Freddie', last_name: 'Dixon', title: 'Data Scientist', company: 'Ubisoft', favorite: true,
               user_id: 1)

Contact.create(first_name: 'Adam', last_name: 'Jenkins', title: 'Marketing Manager', company: 'Adobe', user_id: 1)

Contact.create(first_name: 'Amy', last_name: 'Gray', title: 'Accountant', company: 'Canon', favorite: true, user_id: 1)

Contact.create(first_name: 'Sophie', last_name: 'Bailey', title: 'Front End Developer', company: 'Oracle',
               favorite: true, user_id: 1)
