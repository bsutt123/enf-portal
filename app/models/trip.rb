class Trip < ApplicationRecord
  belongs_to :trip_group, polymorphic: true
  belongs_to :session
  belongs_to :session_counselor

  default_scope { order('start ASC') }

  has_one :food

  has_many :trip_campers, :dependent => :destroy
  has_many :session_campers, :through => :trip_campers

  has_many :trip_counselors, :dependent => :destroy
  has_many :session_counselors, :through => :trip_counselors

  has_many :trip_vans, :dependent => :destroy
  has_many :session_vans, :through => :trip_vans

  belongs_to :start_day, :class_name => "Day", :foreign_key => 'start_day_id'
  belongs_to :end_day, :class_name => "Day", :foreign_key => 'end_day_id'

  def self.overlapping_approved_trips(trip)
    where("start BETWEEN :trip_start AND :trip_end OR finish BETWEEN :trip_start AND :trip_end OR start <= :trip_start AND finish >= :trip_end", {trip_start: trip.start, trip_end: trip.finish})
  end

  def self.overlaps_lunch_on(date)
    lunch_start = DateTime.new(date.year, date.month, date.day, 12,0,0)
    lunch_end = DateTime.new(date.year, date.month, date.day, 2,15,0)
    where("start BETWEEN :lunch_start AND :lunch_end OR finish BETWEEN :lunch_start AND :lunch_end OR start <= :lunch_start AND finish >= :lunch_end", {lunch_start: lunch_start, lunch_end: lunch_end})
  end


  def self.day_trips_off_campus(date)
    time_line = (date..(date+1))
    where(start: time_line, approved: true, day_trip: true)
  end

  def self.multi_day_starts(date)
    time_line = (date..(date+1))
    where(approved:true).where(start: time_line, day_trip:false)
  end

  def self.multi_day_ends(date)
    time_line = (date..(date+1))
    where(approved: true).where(finish: time_line, day_trip:false)
  end

  def self.multi_day_all_day(date)
    date_hash = {start_date: date, finish_date: (date+1) }
    where(approved: true).where("start < :start_date AND finish > :finish_date",date_hash)
  end
end
