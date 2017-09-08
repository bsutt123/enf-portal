class TripCounselor < ApplicationRecord
  belongs_to :session_counselor
  belongs_to :trip
end
