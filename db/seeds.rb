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
Counselor.create!(
  name: "Standard"
)
User.create!(
  email: "standard@example.com",
  password: "password",
  password_confirmation: "password",
  role: "standard",
  counselor_id: Counselor.find_by(name: "Standard")[:id]
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


session_one = Session.create!(
  number: 1,
  start: Date.new(2018,6,9),
  finish: Date.new(2018,6,22),
  identifier: "Session 1 2018"
)
Cabin.numbers.keys.each do |number|
  session_one.cabins.create(number: number)
end

session_two = Session.create!(
  number: 2,
  start: Date.new(2018,6,24),
  finish: Date.new(2018,7,14),
  identifier: "Session 2 2018"
)
Cabin.numbers.keys.each do |number|
  session_two.cabins.create(number: number)
end

session_three = Session.create!(
  number: 3,
  start: Date.new(2018,7,16),
  finish: Date.new(2018,8,6),
  identifier: "Session 3 2018"
)
Cabin.numbers.keys.each do |number|
  session_three.cabins.create(number: number)
end

session_four = Session.create!(
  number: 4,
  start: Date.new(2018,8,8),
  finish: Date.new(2018,8,16),
  identifier: "Session 4 2018"
)
Cabin.numbers.keys.each do |number|
  session_four.cabins.create(number: number)
end


sessions = Session.all
campers = Camper.all
counselors = Counselor.all

sessions.each do |session|
  campers.each do |camper|
    SessionCamper.create(
      session: session,
      camper: camper,
      cabin: session.cabins.sample
    )
  end
  session_campers = session.session_campers
  counselors.each do |counselor|
    SessionCounselor.create!(
      session: session,
      counselor: counselor,
      cabin: session.cabins.sample
    )
  end
  session_counselors = session.session_counselors
  10.times do
    enf_class = EnfClass.create!(
      session: session,
      name: Faker::Seinfeld.quote
    )

    rand(8..12).times do
      Student.create!(enf_class: enf_class, session_camper: session_campers.sample)
    end

    rand(1..3).times do
      Instructor.create!(enf_class: enf_class, session_counselor: session_counselors.sample)
    end
  end

end
