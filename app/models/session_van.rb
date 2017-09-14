class SessionVan < ApplicationRecord
  belongs_to :session
  belongs_to :van

  has_many :van_trips
  has_many :trips, :through => :van_trips
end
