class User < ApplicationRecord
  validates_presence_of :name, :email, :password_digest, presence: true
  validates_uniqueness_of :email
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates_presence_of :password_digest
  has_secure_password

  has_many :user_plants
  has_many :plants, through: :user_plants
end
