class Counselor < ApplicationRecord
  has_many :session_counselors
  has_many :cabins, :through => :session_counselors
  has_many :sessions, :through => :session_counselors

  has_one :user
  accepts_nested_attributes_for :user
end
