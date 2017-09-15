class Period < ApplicationRecord
  belongs_to :day
  enum name: [ :one, :two, :three, :four, :twilight ]

end
