class Trip < ApplicationRecord
  belongs_to :trip_group, polymorphic: true
  belongs_to :session
  belongs_to :session_counselor

  has_many :trip_campers
  has_many :session_campers, :through => :trip_campers

  has_many :trip_counselors
  has_many :session_counselors, :through => :trip_counselors
end
