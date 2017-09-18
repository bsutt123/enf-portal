# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'date'
require 'faker'

Counselor.where(name: "Brady").first_or_create!(
  driver: true,
  lifeguard: true,
  wfa: true
)
User.where(email: "bsutt123@gmail.com").first_or_create!(
  password: "password",
  password_confirmation: "password",
  role: "admin",
  counselor_id: Counselor.find_by(name: "Brady")[:id]
)
Counselor.where(name: "Standard").first_or_create!(
  name: "Standard",
  lifeguard: Faker::Boolean.boolean,
  wfa: Faker::Boolean.boolean,
  driver: Faker::Boolean.boolean,
)
User.where(email: "standard@example.com").first_or_create!(
  password: "password",
  password_confirmation: "password",
  role: "standard",
  counselor_id: Counselor.find_by(name: "Standard")[:id]
)
Faker::UniqueGenerator.clear
50.times do
  Camper.create!(
    name:Faker::Name.unique.name,
    non_swimmer:Faker::Boolean.boolean(0.5),
    has_food_allergies:Faker::Boolean.boolean,
    has_medication:Faker::Boolean.boolean
  )
end

20.times do
  counselor = Counselor.create!(
    name:Faker::GameOfThrones.character,
    lifeguard: Faker::Boolean.boolean,
    wfa: Faker::Boolean.boolean,
    driver: Faker::Boolean.boolean
  )
  User.create!(
    email:Faker::Internet.unique.email,
    password: "password",
    password_confirmation: "password",
    counselor: counselor
  )
end



(1..10).each do |number|
  Van.create!(number: number, capacity: 15)
end
all_periods = ["one", 'two', 'three', 'four', 'one_and_two_mwf', 'one_and_two_tts', 'three_and_four_mwf', 'three_and_four_tts', 'twilight']
regular_periods = ['one','two','three','four']

classes = [
  ["Adv Canoe", "one"],
  ["Int Canoe", "two"],
  ["Beg Canoe", "three"],
  ["Lake Canoe", "four"],
  ["Adv Rocks", "one"],
  ["Int Rocks", "two"],
  ["Beg Rocks", "three"],
  ["Young Rocks", "four"],
  ["Ceramics", "one"],
  ["Archery", "two"],
  ["Young Campcraft", "three"],
  ["X-Craft", "four"],
  ["Adv Swim", "one"],
  ["Int Swim", "two"],
  ["Beg Swim", "three"],
  ["Young Swim", "four"],
  ["Walks and Waterfalls A", "one_and_two_mwf"],
  ["Walks and Waterfalls B", "one_and_two_tts"],
  ["Walks and Waterfalls C", "three_and_four_mwf"],
  ["Walks and Waterfalls D", "three_and_four_tts"],
  ["Athletics Twilight", "twilight"],
  ["Arts and Crafts Twilight", "twilight"],
  ["Lake Twilight", "twilight"],
  ["Random Fun Twilight", "twilight"],
  ["Chill Twilight", "twilight"]
]



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
vans = Van.all
sessions.each do |session|
  vans.each do |van|
    SessionVan.create!(
      session: session,
      van: van
    )
  end


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
  classes.each do |class_info|
    enf_class = EnfClass.create!(
      name: class_info[0],
      session: session,
      period: class_info[1]
    )

    class_campers = session_campers.sample(rand(8..12))
    class_campers.each do |camper|
      Student.create!(
        enf_class: enf_class,
        session_camper: camper,
        days_attend: "every"
      )
    end

    class_counselors = session_counselors.sample(rand(2..3))
    class_counselors.each do |counselor|
      Instructor.create!(
        enf_class: enf_class,
        session_counselor: counselor,
        days_attend: "every"
      )
    end
  end

  enf_classes = session.enf_classes.where.not(period: "twilight")
  20.times do
    day = session.days.sample
    date = day.date
    trip = session.trips.create!(
      description: Faker::Pokemon.name,
      destination: Faker::LordOfTheRings.location,
      requires_food: Faker::Boolean.boolean,
      requires_gear: Faker::Boolean.boolean,
      requires_van: true,
      requires_lifeguard: Faker::Boolean.boolean,
      requires_wfa: Faker::Boolean.boolean,
      start_day: day,
      end_day: day,
      day_trip: true,
      start: DateTime.new(date.year, date.month, date.day, 9,0,0),
      finish: DateTime.new(date.year, date.month, date.day, 17,0,0),
      session_counselor: session_counselors.sample,
      trip_group_id: enf_classes.sample[:id],
      trip_group_type: "EnfClass",
      approved: true,
    )
    trip_group = trip.trip_group
    trip_group.session_counselors.each do |s_counselor|
      TripCounselor.create(session_counselor: s_counselor, trip: trip)
    end

    trip_group.session_campers.each do |s_camper|
      TripCamper.create(session_camper: s_camper, trip: trip)
    end


  end

end
