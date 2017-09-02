class EnfClass < ApplicationRecord
  has_many :students
  has_many :instructors

  has_many :campers, :through => :students
  has_many :counselors, :through => :instructors
end
