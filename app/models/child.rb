class Child < ApplicationRecord
  belongs_to :user
  belongs_to :school
  has_many :session_bookings
end
