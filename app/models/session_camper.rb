class SessionCamper < ApplicationRecord
  default_scope {order("cabin_id ASC")}

  belongs_to :session
  belongs_to :cabin
  belongs_to :camper


  has_many :trip_campers
  has_many :trips, :through => :trip_campers

  has_many :students
  has_many :enf_classes, :through => :students
end
