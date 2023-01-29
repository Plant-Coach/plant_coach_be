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

  def establish_and_save_frost_dates
    frost_dates = FrostDateFacade.get_frost_dates(self.zip_code)
    self.spring_frost_dates = frost_dates.spring_frost
    self.fall_frost_dates = frost_dates.fall_frost
  end

  def started_indoor_seeds
    GardenPlant.where(
                      start_from_seed: true,
                      direct_seed_recommendation: :no,
                      planting_status: 1, # 1 = "started"
                      actual_transplant_date: nil
                    )
               .order('projected_seedling_transplant_date ASC')
  end

  def plants_waiting_to_be_started
    GardenPlant.where(actual_seed_sewing_date: nil, planting_status: "not_started")
               .order("recommended_seed_sewing_date ASC")
  end

  def plants_in_the_garden
    GardenPlant.where(planting_status: "transplanted_outside")
               .where.not(actual_transplant_date: nil)
  end
end
