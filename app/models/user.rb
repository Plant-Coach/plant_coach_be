class User < ApplicationRecord
  validates :name, presence: { message: "The user's name must not be blank!" }
  validates :password_digest, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: lambda do |object, _data|
    "#{object.email} is not a valid email address!!"
  end },
                    presence: true
  validates :email, uniqueness: { message: 'This user already exists!!' }
  validates :spring_frost_date,
            presence: { message: 'The spring frost date is not being provided and causing failure.' }, on: :update
  validates :fall_frost_date, presence: { message: 'The fall frost date is not being provided and causing failure.' },
                              on: :update
  has_secure_password

  validates_associated :plants

  has_many :plants
  has_many :plant_guides, dependent: :destroy
  has_many :garden_plants, through: :plants

  after_create :load_default_plant_guides
  before_create :establish_frost_dates
  before_update :establish_frost_dates, if: :zip_code_changed?

  # Returns the zip codes of all users in the database.  The corresponding
  # ids also need to be returned.
  def self.all_zip_codes
    all.select(:id, :zip_code)
  end

  def load_default_plant_guides
    PlantGuideMaster.all.each do |plant_guide|
      plant_guides.create(
        plant_type: plant_guide.plant_type,
        seedling_days_to_transplant: plant_guide.seedling_days_to_transplant,
        days_to_maturity: plant_guide.days_to_maturity,
        days_relative_to_frost_date: plant_guide.days_relative_to_frost_date,
        harvest_period: plant_guide.harvest_period,
        direct_seed_recommended: plant_guide.direct_seed_recommended
      )
    end
  end

  def establish_frost_dates
    frost_dates = FrostDateFacade.get_frost_dates(zip_code)
    self.spring_frost_date = frost_dates.spring_frost
    self.fall_frost_date = frost_dates.fall_frost
  end

  def started_indoor_seeds
    GardenPlant.where(
      # start_from_seed: true,
      direct_seed_recommended: false,
      planting_status: 1, # 1 = "started"
      actual_transplant_date: nil
    )
               .order('recommended_transplant_date ASC')
  end

  def plants_waiting_to_be_started
    GardenPlant.where(actual_seed_sewing_date: nil, planting_status: 'not_started')
               .order('recommended_seed_sewing_date ASC')
  end

  def plants_in_the_garden
    GardenPlant.where(planting_status: 'transplanted_outside')
               .where.not(actual_transplant_date: nil)
  end
end
