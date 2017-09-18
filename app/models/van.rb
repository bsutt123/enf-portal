class Van < ApplicationRecord
  has_many :session_vans, :dependent => :destroy
  has_many :sessions, :through => :session_vans
end
