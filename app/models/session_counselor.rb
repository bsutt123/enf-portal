class SessionCounselor < ApplicationRecord
  default_scope {order("cabin_id ASC")}

  belongs_to :session
  belongs_to :cabin
  belongs_to :counselor


  has_many :trips, :source => :trip

  has_many :trip_counselors
  has_many :group_trips, :through => :trip_counselors, :source => :trip

  has_many :instructors, inverse_of: :session_counselor, :dependent => :destroy
  has_many :enf_classes, :through => :instructors

  accepts_nested_attributes_for :instructors
end
