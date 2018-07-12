class SessionBooking < ApplicationRecord
  belongs_to :availability
  belongs_to :user
  belongs_to :child
end
