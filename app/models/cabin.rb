class Cabin < ApplicationRecord
  has_many :session_campers
  has_many :campers, :through => :session_campers

  has_many :session_counselors
  has_many :counselors, :through => :session_counselors
  
  belongs_to :session

  enum number: [:no_cabin, :lib, :one, :two, :three, :four, :five, :six, :seven,
                :eight, :nine, :ten, :TT, :out_of_cabin]
end
