class User < ApplicationRecord
  has_secure_password

  has_many :minder_contracts, class_name: "Contract", foreign_key:"child_minder_id"
  has_many :parent_bosses, through: :minder_contracts, source: :parent
  has_many :parent_contracts, class_name: "Contract", foreign_key:"parent_id"
  has_many :minders, through: :parent_contracts, source: :child_minder
  has_many :children

  accepts_nested_attributes_for :children, reject_if: proc { |attributes| attributes['name'].blank? }

  def password=(new_password)
     salt = bcrypt_engine::generate_salt
     hash = bcrypt_engine::hash_secret(new_password, salt)
     self.password_digest = salt + hash
  end

  def authenticate(password)
     salt = password_digest[0..28]
     hash = BCrypt::Engine::hash_secret(password, salt)
     return nil unless salt+hash = self.password_digest
  end

  def bcrypt_engine
     BCrypt::Engine
  end

end
