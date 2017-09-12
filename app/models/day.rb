class Day < ApplicationRecord
  has_many :periods
  belongs_to :session
  enum style: [:weekday, :saturday, :sunday]

  has_many :trip_starts, :class_name => 'Trip', :foreign_key => "start_day_id"
  has_many :trip_ends, :class_name => 'Trip', :foreign_key => "end_day_id" 

end
