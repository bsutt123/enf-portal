class Counselor < ApplicationRecord
  has_many :instructors
  has_many :enf_classes, :through => :instructors

  has_many :cabin_counselors
  has_many :cabins, :through => :cabin_counselors

  has_one :user
  accepts_nested_attributes_for :user
end
