class Period < ApplicationRecord
  belongs_to :day
  enum name: [:flag, :breakfast, :one, :two, :lunch, :rest, :three, :four,
              :dinner, :twilight, :snack, :evening]

end
