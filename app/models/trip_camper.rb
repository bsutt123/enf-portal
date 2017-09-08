class TripCamper < ApplicationRecord
  t.belongs_to :session_camper
  t.belongs_to :trip
end
