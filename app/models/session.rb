class Session < ApplicationRecord
  has_many :enf_classes
  has_many :cabins
  has_many :trips
  has_many :days

  has_many :session_campers, :dependent => :destroy
  has_many :campers, :through => :session_campers

  has_many :session_counselors, :dependent => :destroy
  has_many :counselors, :through => :session_counselors

  has_many :session_vans, :dependent => :destroy
  has_many :vans, :through => :session_vans

end
