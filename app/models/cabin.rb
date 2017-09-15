class Cabin < ApplicationRecord
  has_many :session_campers
  has_many :campers, :through => :session_campers

  has_many :session_counselors
  has_many :counselors, :through => :session_counselors

  belongs_to :session

  has_many :trips, as: :trip_group

  enum number: [:no_cabin, :lib, :one, :two, :four, :five, :three, :nine, :seven, :eight, :six, :ten, :TT, :out_of_cabin]
end
