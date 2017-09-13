class SessionVan < ApplicationRecord
  belongs_to :session
  belongs_to :van
end
