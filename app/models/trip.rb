class Trip < ApplicationRecord
  belongs_to :trip_group, polymorphic: true
end
