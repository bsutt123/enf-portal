class Instructor < ApplicationRecord
  belongs_to :enf_class
  belongs_to :session_counselor
end
