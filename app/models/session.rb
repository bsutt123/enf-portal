class Session < ApplicationRecord
  has_many :enf_classes
  has_many :cabins
  has_many :trips

  has_many :session_campers
  has_many :campers, :through => :session_campers

  has_many :session_counselors
  has_many :counselors, :through => :session_counselors


end
