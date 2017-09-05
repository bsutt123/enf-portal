class Counselor < ApplicationRecord
  has_many :instructors
  has_many :enf_classes, :through => :instructors

  has_many :cabin_counselors
  has_many :cabins, :through => :cabin_counselors

  belongs_to :user

end
