class TripCamper < ApplicationRecord
  belongs_to :session_camper
  belongs_to :trip
end
