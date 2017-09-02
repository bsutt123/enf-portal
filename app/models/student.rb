class Student < ApplicationRecord
  belongs_to :camper
  belongs_to :enf_class  
end
