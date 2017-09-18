class Camper < ApplicationRecord
  default_scope { order('name ASC') }

  has_many :session_campers, :dependent => :destroy
end
