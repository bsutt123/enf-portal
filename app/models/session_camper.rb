class SessionCamper < ApplicationRecord
  belongs_to :session
  belongs_to :cabin
  belongs_to :camper


  has_many :trip_campers
  has_many :trips, :through => :trip_campers
  
  has_many :students
  has_many :enf_classes, :through => :students
end
