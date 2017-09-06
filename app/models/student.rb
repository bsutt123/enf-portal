class Student < ApplicationRecord
  belongs_to :session_camper
  belongs_to :enf_class
end
