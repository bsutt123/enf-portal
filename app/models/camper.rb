class Camper < ApplicationRecord
  has_many :students
  has_many :enf_classes, :through => :students

  belongs_to :cabin
  belongs_to :session
end
