class EnfClass < ApplicationRecord
  belongs_to :session

  has_many :trips, as: :trip_group, :dependent => :destroy

  has_many :students, :dependent => :destroy
  has_many :session_campers, :through => :students

  has_many :instructors, :dependent => :destroy
  has_many :session_counselors, :through => :instructors

  enum period: [:one, :two, :three, :four, :one_and_two_mwf, :one_and_two_tts, :three_and_four_mwf, :three_and_four_tts, :twilight]
end
