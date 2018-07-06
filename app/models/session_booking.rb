class SessionBooking < ApplicationRecord
  belongs_to :session
  belongs_to :user
  belongs_to :child
end
