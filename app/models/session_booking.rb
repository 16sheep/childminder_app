class SessionBooking < ApplicationRecord
  belongs_to :availability
  belongs_to :user
  belongs_to :child
  validates :time_from, presence: true
  validates :time_until, presence: true
  validates :number_of_children, presence: true
end
