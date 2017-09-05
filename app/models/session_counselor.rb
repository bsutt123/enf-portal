class SessionCounselor < ApplicationRecord
  belongs_to :session
  belongs_to :cabin
  belongs_to :counselor

  has_many :instructors
  has_many :enf_classes, :through => :instructors
end
