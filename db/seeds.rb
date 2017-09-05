# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'date'
require 'faker'

Counselor.create!(
  name: "Brady"
)
User.create!(
  email: "bsutt123@gmail.com",
  password: "password",
  password_confirmation: "password",
  role: "admin",
  counselor_id: Counselor.find_by(name: "Brady")[:id]
)
Faker::UniqueGenerator.clear
50.times do
  Camper.create!(
    name:Faker::Name.unique.name
  )
end

20.times do
  counselor = Counselor.create!(
    name:Faker::GameOfThrones.character
  )
  User.create!(
    email:Faker::Internet.unique.email,
    password: "password",
    password_confirmation: "password",
    counselor: counselor
  )
end
