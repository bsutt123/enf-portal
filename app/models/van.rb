class Van < ApplicationRecord
  has_many :session_vans
  has_many :sessions, :through => :session_vans
end
