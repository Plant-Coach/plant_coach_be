class User < ApplicationRecord
  validates_presence_of :name, :email, :password_digest, presence: true
  validates_uniqueness_of :email
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates_presence_of :password_digest
  has_secure_password

  has_many :plants

  def find_users_plants
    plants.where('user_plants.user_id = ?', "#{self.id}")
  end

  def find_user_plant_by_plant_id(id)
    user_plants.where(plant_id: id).first
  end

  # Created it like this in order to maintain a many-to
  # def create_unique_plant(plant_details)
  #   existing_plant = plants.where('name = ?', plant_details["name"])
  #   if existing_plant.empty?
  #     Plant.create(plant_details)
  #   else
  #     "This plant already exists!"
  #   end
  # end
end
