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

  before_create :establish_and_save_frost_dates

  # Returns the zip codes of all users in the database.  The corresponding
  # ids are also returned.
  def self.all_zip_codes
    all.select(:id, :zip_code)
  end

  def planting_status_maker(decision)
    if decision == "yes"
      return "planted"
    elsif decision == "no"
      return "not planted"
    end
  end

  def create_garden_plant(basic_plant_data, start_from_seed, plant_now)
    # require 'pry'; binding.pry
    garden_plants.create(
      name: basic_plant_data[:name],
      days_to_maturity: basic_plant_data[:days_to_maturity],
      hybrid_status: basic_plant_data[:hybrid_status],
      days_relative_to_frost_date: basic_plant_data[:days_relative_to_frost_date],
      plant_type: basic_plant_data[:plant_type],
      organic: basic_plant_data[:organic],
      recommended_transplant_date: self.spring_frost_dates.to_date + basic_plant_data[:days_relative_to_frost_date],
      direct_seed: SeedDefaultData.find_by(plant_type: basic_plant_data[:plant_type]).direct_seed,
      start_from_seed: start_from_seed,
      recommended_seed_sewing_date: self.spring_frost_dates.to_date + basic_plant_data[:days_relative_to_frost_date] - SeedDefaultData.find_by(plant_type: basic_plant_data[:plant_type]).seedling_days_to_transplant,
      seedling_days_to_transplant: SeedDefaultData.find_by(plant_type: basic_plant_data[:plant_type]).seedling_days_to_transplant,
      planting_status: planting_status_maker(plant_now)# Statuses: Waiting sewing, sewed, transplanted_outside, harvest, finished
    )

  end

  def establish_and_save_frost_dates
    frost_dates = FrostDateFacade.get_frost_dates(self.zip_code)
    self.spring_frost_dates = frost_dates.spring_frost
    self.fall_frost_dates = frost_dates.fall_frost
  end
end
