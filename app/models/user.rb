class User < ApplicationRecord
  validates_presence_of :name, :email, :password_digest, presence: true
  validates_uniqueness_of :email
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates_presence_of :password_digest
  has_secure_password

  has_many :plants
  has_many :garden_plants

  def find_users_plants
    plants.where('user_plants.user_id = ?', "#{self.id}")
  end

  def find_user_plant_by_plant_id(id)
    user_plants.where(plant_id: id).first
  end

  def self.all_zip_codes
    all.select(:id, :zip_code)
  end
end
