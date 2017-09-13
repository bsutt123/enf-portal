class Trip < ApplicationRecord
  belongs_to :trip_group, polymorphic: true
  belongs_to :session
  belongs_to :session_counselor

  has_many :trip_campers
  has_many :session_campers, :through => :trip_campers

  has_many :trip_counselors
  has_many :session_counselors, :through => :trip_counselors

  has_many :trip_vans
  has_many :session_vans, :through => :trip_vans

  belongs_to :start_day, :class_name => "Day", :foreign_key => 'start_day_id'
  belongs_to :end_day, :class_name => "Day", :foreign_key => 'end_day_id'
end
