class Contract < ApplicationRecord
  belongs_to :parent, class_name: "User"
  belongs_to :child_minder, class_name: "User"
end
