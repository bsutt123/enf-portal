class Cabin < ApplicationRecord
  has_many :campers
  has_many :counselors

  belongs_to :session

  enum number: [:no_cabin, :lib, :one, :two, :three, :four, :five, :six, :seven,
                :eight, :nine, :ten, :TT, :out_of_cabin]
end
