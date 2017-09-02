class Counselor < ApplicationRecord
  has_many :instructors
  has_many :enf_classes, :through => :instructors

  belongs_to :cabin
  belongs_to :user

end
