class Cabin < ApplicationRecord
  has_many :campers
  has_many :counselors
end
