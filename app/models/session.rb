class Session < ApplicationRecord
  has_many :campers
  has_many :enf_classes
  has_many :cabins
end
