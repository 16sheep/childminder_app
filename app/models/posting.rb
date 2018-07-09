class Posting < ApplicationRecord
  belongs_to :school
  belongs_to :user
  has_many :availabilities
end
