class User < ApplicationRecord
  validates_presence_of :name, :email
  validates_uniqueness_of :email
  validates_presence_of :password_digest
  has_secure_password

  has_many :user_plants
  has_many :plants, through: :user_plants
end
