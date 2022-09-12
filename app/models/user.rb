class User < ApplicationRecord
  validates_presence_of :name, :email, :password_digest, presence: true
  validates_uniqueness_of :email
  # Only allowed formatting for email addresses.
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates_presence_of :password_digest
  # Bcrypt method to encrypt the password digest (above).
  has_secure_password
  # Users can have plants.
  has_many :plants
  # USers can have garden plants.
  has_many :garden_plants

  # Returns the zip codes of all users in the database.  The corresponding
  # ids are also returned.
  def self.all_zip_codes
    all.select(:id, :zip_code)
  end
end
