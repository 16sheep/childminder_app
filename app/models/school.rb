class School < ApplicationRecord
  has_many :children, dependent: :destroy
  has_many :postings, dependent: :destroy
  has_many :users, through: :postings, dependent: :destroy
end
