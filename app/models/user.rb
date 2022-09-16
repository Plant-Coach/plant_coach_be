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

  after_validation :establish_and_save_frost_dates

  # Returns the zip codes of all users in the database.  The corresponding
  # ids are also returned.
  def self.all_zip_codes
    all.select(:id, :zip_code)
  end

  def create_garden_plant(basic_plant_data)
    garden_plants.create(
      name: basic_plant_data[:name],
      days_to_maturity: basic_plant_data[:days_to_maturity],
      hybrid_status: basic_plant_data[:hybrid_status],
      days_relative_to_frost_date: basic_plant_data[:days_relative_to_frost_date],
      plant_type: basic_plant_data[:plant_type],
      organic: basic_plant_data[:organic],
      recommended_transplant_date: self.spring_frost_dates.to_date + basic_plant_data[:days_relative_to_frost_date]
    )
  end

  def establish_and_save_frost_dates
    frost_dates = FrostDateFacade.get_frost_dates(self.zip_code)
    self.spring_frost_dates = frost_dates.spring_frost
    self.fall_frost_dates = frost_dates.fall_frost
  end
end
