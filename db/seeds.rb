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
  name: "Standard",
  lifegaurd: Faker::Boolean.boolean,
  wfa: Faker::Boolean.boolean,
  driver: Faker::Boolean.boolean
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

dates = [
        Date.new(2018,6,9),
        Date.new(2018,6,22),
        Date.new(2018,6,24),
        Date.new(2018,7,13),
        Date.new(2018,7,15),
        Date.new(2018,8,3),
        Date.new(2018,8,5),
        Date.new(2018,8,12)]

(0..3).each do |index|
  session = Session.create!(
    number: index+1,
    start: dates[2*index],
    finish: dates[2*index+1],
    identifier: "Session #{index+1} 2018"
  )
  Cabin.numbers.keys.each do |number|
    session.cabins.create(number: number)
  end
  session_dates = (session.start..session.finish).to_a
  session_dates.each do |date|
    day = session.days.create(date: date)
  end
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

  enf_classes = EnfClass.all
  20.times do
    day = session.days.sample
    trip = session.trips.create!(
      description: Faker::Pokemon.name,
      destination: Faker::LordOfTheRings.location,
      requires_food: Faker::Boolean.boolean,
      requires_gear: Faker::Boolean.boolean(0.1),
      start_day: day,
      end_day: day,
      start_period: "one",
      end_period: "four",
      session_counselor: session_counselors.sample,
      trip_group_id: enf_classes.sample[:id],
      trip_group_type: "EnfClass"
    )
  end

end
