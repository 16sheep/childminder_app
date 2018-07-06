class User < ApplicationRecord
  has_many :minder_contracts, class_name: "Contract", foreign_key:"child_minder_id"
  has_many :parent_bosses, through: :minder_contracts, source: :parent
  has_many :parent_contracts, class_name: "Contract", foreign_key:"parent_id"
  has_many :minders, through: :parent_contracts, source: :child_minder
end
