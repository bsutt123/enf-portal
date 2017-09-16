class SessionCounselor < ApplicationRecord
  default_scope {order("cabin_id ASC")}

  belongs_to :session
  belongs_to :cabin
  belongs_to :counselor


  has_many :trips, :source => :trip

  has_many :trip_counselors
  has_many :group_trips, :through => :trip_counselors, :source => :trip

  has_many :instructors
  has_many :enf_classes, :through => :instructors
end
