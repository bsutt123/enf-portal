class EnfClass < ApplicationRecord
  has_many :students
  has_many :instructors
  belongs_to :session

  has_many :trips, as: :trip_group

  has_many :session_campers, :through => :students
  has_many :session_counselors, :through => :instructors
end
