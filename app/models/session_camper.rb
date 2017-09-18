class SessionCamper < ApplicationRecord
  default_scope {order("cabin_id ASC")}

  belongs_to :session
  belongs_to :cabin
  belongs_to :camper


  has_many :trip_campers, :dependent => :destroy
  has_many :trips, :through => :trip_campers

  has_many :students, inverse_of: :session_camper, :dependent => :destroy
  has_many :enf_classes, :through => :students

  accepts_nested_attributes_for :students

end
