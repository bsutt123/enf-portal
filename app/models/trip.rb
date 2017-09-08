class Trip < ApplicationRecord
  belongs_to :trip_group, polymorphic: true
  belongs_to :session
  belongs_to :session_counselor

end
