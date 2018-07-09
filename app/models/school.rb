class School < ApplicationRecord
  has_many :children
  has_many :postings
  has_many :users, through: :postings
end
