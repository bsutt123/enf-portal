class Student < ApplicationRecord
  belongs_to :session_camper
  belongs_to :enf_class


  enum days_attend: [:every, :mwf, :tts]
end
