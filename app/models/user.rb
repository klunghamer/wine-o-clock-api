class User < ApplicationRecord
  has_many :bottles
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
end
