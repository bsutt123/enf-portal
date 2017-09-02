# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'date'


Session.create!(
  number: 1,
  start: Date.new(2018,6,9),
  finish: Date.new(2018,6,22),
  identifier: "session_1_2018"
)

Session.create!(
  number: 2,
  start: Date.new(2018,6,24),
  finish: Date.new(2018,7,13),
  identifier: "session_2_2018"
)

Session.create!(
  number: 3,
  start: Date.new(2018,7,15),
  finish: Date.new(2018,8,3),
  identifier: "session_3_2018"
)

Session.create!(
  number: 1,
  start: Date.new(2018,8,5),
  finish: Date.new(2018,8,12),
  identifier: "session_4_2018"
)
