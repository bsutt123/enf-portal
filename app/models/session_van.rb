class SessionVan < ApplicationRecord
  belongs_to :session
  belongs_to :van

  has_many :trip_vans, :dependent => :destroy
  has_many :trips, :through => :trip_vans
end
