class TripVan < ApplicationRecord
  belongs_to :session_van
  belongs_to :trip
end
